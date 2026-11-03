import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:customer_app/core/config/app_config.dart';
import 'package:customer_app/core/error/api_exception.dart';
import 'package:http/http.dart' as http;

/// Thin wrapper over [http.Client] that turns transport details into
/// decoded JSON or a typed [ApiException].
///
/// Screens and blocs never touch `http` directly, which keeps networking
/// swappable and makes everything above this layer easy to test.
class ApiClient {
  ApiClient({http.Client? httpClient, String? baseUrl})
    : _httpClient = httpClient ?? http.Client(),
      _baseUrl = baseUrl ?? AppConfig.apiBaseUrl;

  final http.Client _httpClient;
  final String _baseUrl;

  Future<Map<String, dynamic>> postJson(
    String path,
    Map<String, dynamic> body,
  ) async {
    final uri = Uri.parse('$_baseUrl$path');

    late final http.Response response;
    try {
      response = await _httpClient
          .post(
            uri,
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(AppConfig.requestTimeout);
    } on TimeoutException {
      throw const ApiException(
        'The server took too long to respond. Please try again.',
        type: ApiFailureType.timeout,
      );
    } on SocketException {
      throw const ApiException(
        'No internet connection. Check your network and try again.',
        type: ApiFailureType.network,
      );
    } on http.ClientException {
      // Also covers the browser's opaque CORS failure on web builds.
      throw const ApiException(
        'Could not reach the server. Check your connection and try again.',
        type: ApiFailureType.network,
      );
    }

    return _decode(response);
  }

  Map<String, dynamic> _decode(http.Response response) {
    final status = response.statusCode;

    Map<String, dynamic>? json;
    if (response.body.isNotEmpty) {
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) json = decoded;
      } on FormatException {
        json = null;
      }
    }

    if (status >= 200 && status < 300) {
      if (json == null) {
        throw const ApiException(
          'The server returned an unexpected response.',
          type: ApiFailureType.malformedResponse,
        );
      }
      return json;
    }

    // Prefer the server's own wording - it is the most specific thing we have.
    final serverMessage = json?['message'] ?? json?['error'];
    final message = serverMessage is String && serverMessage.trim().isNotEmpty
        ? serverMessage
        : _fallbackMessage(status);

    throw ApiException(
      message,
      type: status >= 500 ? ApiFailureType.server : ApiFailureType.badRequest,
      statusCode: status,
    );
  }

  String _fallbackMessage(int status) {
    if (status >= 500) {
      return 'The server is having trouble right now. Please try again later.';
    }
    if (status == 404) return 'That service could not be found.';
    if (status == 401 || status == 403) {
      return 'You are not authorised to do that.';
    }
    return 'Something went wrong. Please try again.';
  }

  void dispose() => _httpClient.close();
}

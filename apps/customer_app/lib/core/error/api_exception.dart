/// Why a request failed, in terms the UI can act on.
enum ApiFailureType {
  /// No usable internet connection.
  network,

  /// The server took too long to answer.
  timeout,

  /// 4xx - the request itself was rejected (validation, duplicate email...).
  badRequest,

  /// 5xx - the server broke. Retrying may help.
  server,

  /// The response was not the JSON we expected.
  malformedResponse,

  /// Anything we did not anticipate.
  unknown,
}

/// A failure that already carries a message safe to show to a user.
class ApiException implements Exception {
  const ApiException(this.message, {required this.type, this.statusCode});

  final String message;
  final ApiFailureType type;
  final int? statusCode;

  /// True when retrying the same request could plausibly succeed.
  bool get isRetryable =>
      type == ApiFailureType.network ||
      type == ApiFailureType.timeout ||
      type == ApiFailureType.server;

  @override
  String toString() => 'ApiException($type, $statusCode): $message';
}

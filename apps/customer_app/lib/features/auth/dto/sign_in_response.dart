import 'package:equatable/equatable.dart';

/// What the signin endpoint returns on success:
/// `{"message": "Signed in successfully"}`
///
/// Cognito itself hands back ID/access/refresh tokens on a successful auth.
/// If the Lambda is updated to forward them, they are picked up here
/// automatically - several common key spellings are accepted so the app does
/// not need changing.
class SignInResponse extends Equatable {
  const SignInResponse({
    required this.message,
    this.idToken,
    this.accessToken,
    this.refreshToken,
  });

  final String message;
  final String? idToken;
  final String? accessToken;
  final String? refreshToken;

  /// True when the backend returned something we could keep a session with.
  bool get hasSession => idToken != null || accessToken != null;

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    // Tokens are sometimes nested under AuthenticationResult (raw Cognito).
    final nested = json['AuthenticationResult'];
    final tokens = nested is Map<String, dynamic> ? nested : json;

    String? read(List<String> keys) {
      for (final key in keys) {
        final value = tokens[key];
        if (value is String && value.trim().isNotEmpty) return value;
      }
      return null;
    }

    final message = json['message'];
    return SignInResponse(
      message: message is String && message.trim().isNotEmpty
          ? message
          : 'Signed in successfully',
      idToken: read(['idToken', 'IdToken', 'id_token']),
      accessToken: read([
        'accessToken',
        'AccessToken',
        'access_token',
        'token',
      ]),
      refreshToken: read(['refreshToken', 'RefreshToken', 'refresh_token']),
    );
  }

  @override
  List<Object?> get props => [message, idToken, accessToken, refreshToken];
}

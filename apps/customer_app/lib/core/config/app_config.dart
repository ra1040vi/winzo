// app_config.dart
/// Environment-level settings.
///
/// Values can be overridden at build time without touching code, e.g.
/// `flutter run --dart-define=API_BASE_URL=https://staging.example.com/prod`.
class AppConfig {
  AppConfig._();

  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://1k96c8zgvf.execute-api.us-east-1.amazonaws.com/prod',
  );

  /// How long to wait before giving up on a request.
  static const requestTimeout = Duration(seconds: 20);
}

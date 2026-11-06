import 'package:customer_app/core/network/api_client.dart';
import 'package:customer_app/features/auth/dto/sign_in_request.dart';
import 'package:customer_app/features/auth/dto/sign_in_response.dart';

class AuthRepository {
  AuthRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();
  final ApiClient _apiClient;

  Future<SignInResponse> signIn(SignInRequest request) async {
    final json = await _apiClient.postJson('/signin', request.toJson());
    return SignInResponse.fromJson(json);
  }

  void dispose() {
    _apiClient.dispose();
  }
}

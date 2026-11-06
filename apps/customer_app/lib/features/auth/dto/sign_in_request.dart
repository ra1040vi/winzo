import 'package:equatable/equatable.dart';

// The payload the signin endpoint expects.
//`{"email":"...","password":"..."}`
class SignInRequest extends Equatable {
  const SignInRequest({required this.username, required this.password});

  final String username;
  final String password;

  Map<String, dynamic> toJson() => {'username': username, 'password': password};

  @override
  List<Object?> get props => [username, password];
}

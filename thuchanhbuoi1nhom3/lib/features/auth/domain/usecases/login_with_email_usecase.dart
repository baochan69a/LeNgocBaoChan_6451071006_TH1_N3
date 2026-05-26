import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmailUseCase {
  final AuthRepository repository;

  LoginWithEmailUseCase(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.loginWithEmail(email, password);
  }
}

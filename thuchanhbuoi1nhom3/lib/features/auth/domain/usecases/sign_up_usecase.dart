import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.signUpWithEmail(email, password);
  }
}

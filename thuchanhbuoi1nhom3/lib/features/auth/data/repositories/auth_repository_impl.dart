import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      final credential = await remoteDataSource.loginWithEmail(email, password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Đã xảy ra lỗi đăng nhập.');
    }
  }

  @override
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final credential = await remoteDataSource.signUpWithEmail(
        email,
        password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Đã xảy ra lỗi đăng ký.');
    }
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}

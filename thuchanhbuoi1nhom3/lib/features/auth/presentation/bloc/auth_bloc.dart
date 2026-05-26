import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_with_email_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailUseCase loginWithEmailUseCase;
  final SignUpUseCase signUpUseCase;

  AuthBloc({required this.loginWithEmailUseCase, required this.signUpUseCase})
    : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginWithEmailUseCase(event.email, event.password);
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthFailure('Không thể lấy thông tin người dùng.'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
      }
    });

    on<SignUpSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signUpUseCase(event.email, event.password);
        if (user != null) {
          // Bạn có thể bổ sung cập nhật DisplayName ở đây nếu cần
          emit(AuthSuccess(user));
        } else {
          emit(AuthFailure('Đăng ký không thành công.'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
      }
    });
  }
}

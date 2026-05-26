import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_with_email_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Khởi tạo bộ điều khiển để lấy dữ liệu từ ô nhập liệu
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Khởi tạo AuthBloc chạy cục bộ cho màn hình này
      create: (context) => AuthBloc(
        loginWithEmailUseCase: LoginWithEmailUseCase(
          AuthRepositoryImpl(AuthRemoteDataSourceImpl(FirebaseAuth.instance)),
        ),
        signUpUseCase: SignUpUseCase(
          AuthRepositoryImpl(AuthRemoteDataSourceImpl(FirebaseAuth.instance)),
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              // Xử lý khi đăng nhập thành công
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đăng nhập thành công!'),
                    backgroundColor: Colors.green,
                  ),
                );
                context.go('/success'); // Chuyển sang màn hình thành công
              }
              // Xử lý khi có lỗi xảy ra (Sai mật khẩu, tài khoản không tồn tại,...)
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textLight),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController, // Gắn bộ điều khiển email
                      decoration: InputDecoration(
                        hintText: 'Brandonelouis@gmail.com',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller:
                          _passwordController, // Gắn bộ điều khiển password
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '••••••••••••',
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Icon(
                          Icons.visibility_off_outlined,
                          color: AppColors.textLight,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (val) {},
                              activeColor: AppColors.primary,
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(color: AppColors.textLight),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => context.go('/forgot-password'),
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(color: AppColors.textDark),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Nếu trạng thái đang loading thì hiện vòng xoay, ngược lại hiện nút bấm gốc của bạn
                    state is AuthLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              // Kích hoạt sự kiện gửi thông tin login lên Firebase Auth
                              context.read<AuthBloc>().add(
                                LoginSubmitted(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Tính năng Google Sign-In có thể bổ sung sau nếu cần
                      },
                      icon: const Icon(
                        Icons.g_mobiledata,
                        size: 30,
                        color: AppColors.primary,
                      ),
                      label: const Text(
                        'SIGN IN WITH GOOGLE',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cardGoogle,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "You don't have an account yet? ",
                            style: TextStyle(color: AppColors.textLight),
                          ),
                          GestureDetector(
                            onTap: () => context.go('/sign-up'),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: AppColors.accent,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

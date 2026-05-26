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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Khởi tạo các bộ điều khiển lấy dữ liệu nhập vào
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Hủy các bộ điều khiển khi thoát trang để tránh tràn bộ nhớ (memory leak)
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Tạo AuthBloc cục bộ cho riêng trang Sign Up này
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
              // Xử lý khi Firebase tạo tài khoản thành công
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đăng ký tài khoản thành công!'),
                    backgroundColor: Colors.green,
                  ),
                );
                context.go(
                  '/success',
                ); // Điều hướng qua màn hình thông báo thành công
              }
              // Xử lý khi gặp lỗi (Email đã tồn tại, mật khẩu quá yếu,...)
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
                    const SizedBox(height: 20),
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Create an Account',
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
                    const SizedBox(height: 30),
                    const Text(
                      'Full name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController, // Gắn bộ điều khiển tên
                      decoration: InputDecoration(
                        hintText: 'Brandon Louis',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
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
                          _passwordController, // Gắn bộ điều khiển mật khẩu
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
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(color: AppColors.textDark),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Logic hiển thị Loading hoặc Nút bấm gốc của bạn
                    state is AuthLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              // Kích hoạt Event đăng ký gửi dữ liệu lên Firebase Auth
                              context.read<AuthBloc>().add(
                                SignUpSubmitted(
                                  name: _nameController.text.trim(),
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
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.g_mobiledata,
                        size: 30,
                        color: AppColors.primary,
                      ),
                      label: const Text(
                        'SIGN UP WITH GOOGLE',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
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
                            onTap: () => context.go('/login'),
                            child: const Text(
                              'Sign in',
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

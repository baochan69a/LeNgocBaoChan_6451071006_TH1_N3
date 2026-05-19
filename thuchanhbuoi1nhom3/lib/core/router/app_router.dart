import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/check_email_page.dart';
import '../../features/auth/presentation/pages/success_page.dart';
import 'app_route_paths.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation:
        AppRoutePaths.splash, // Màn hình đầu tiên xuất hiện khi mở app
    routes: [
      GoRoute(
        path: AppRoutePaths.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutePaths.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutePaths.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRoutePaths.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutePaths.checkEmail,
        builder: (context, state) => const CheckEmailPage(),
      ),
      GoRoute(
        path: AppRoutePaths.success,
        builder: (context, state) => const SuccessPage(),
      ),
    ],
  );
}

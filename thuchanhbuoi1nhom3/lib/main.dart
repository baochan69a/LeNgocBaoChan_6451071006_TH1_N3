import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      // 1. CẤU HÌNH DÀNH CHO WEB (CHROME) - Nạp đống Keys của bạn vào đây
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyA3M_pvws0miEV1TnEevqXLjbHAU1htqKE",
          authDomain: "jobspot-thuchanh.firebaseapp.com",
          projectId: "jobspot-thuchanh",
          storageBucket: "jobspot-thuchanh.firebasestorage.app",
          messagingSenderId: "165474919698",
          appId: "1:165474919698:web:e377befb2e8f66a5883fcb",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    print("Lỗi khởi tạo Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Jobspot Auth UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}

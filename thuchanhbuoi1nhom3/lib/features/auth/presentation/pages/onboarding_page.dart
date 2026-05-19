import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.topRight,
                key: Key('jobspot_label'),
                child: Text(
                  'Jobspot',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const Spacer(),
              const Center(
                child: ClipRRect(
                  child: Image(
                    image: AssetImage('assets/images/onboarding_img.jpg'),
                    width: 311,
                    height: 301,
                    fit: BoxFit.cover,
                  ),
                ), // Minh họa hình ảnh trong figma
              ),
              const Spacer(),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(text: 'Find Your\n'),
                    TextSpan(
                      text: 'Dream Job\n',
                      style: TextStyle(
                        color: AppColors.accent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: 'Here!'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Explore all the most exciting job roles based on your interest and study major.',
                style: TextStyle(color: AppColors.textLight, fontSize: 16),
              ),
              const SizedBox(height: 26),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () => context.go('/login'),
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bantuaku_customer/constants/assets.dart';
import 'package:bantuaku_customer/constants/constants.dart';
import 'package:bantuaku_customer/features/authentication/repository/auth_repository.dart';
import 'package:bantuaku_customer/routing/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _checkLoginStatus(ref, context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Image(image: AssetImage(Assets.splashLogo)),
        ),
      ),
    );
  }

  Future<void> _checkLoginStatus(WidgetRef ref, BuildContext context) async {
    final isLoggedIn = await ref.read(authRepositoryProvider).isLogin();
    debugPrint('${Constants.tag} [SplashScreen._checkLoginStatus] isLoggedIn = $isLoggedIn');
    await Future.delayed(const Duration(seconds: 1));
    if (!context.mounted) return;
    if (isLoggedIn) {
      context.pushReplacement(Routes.main);
    } else {
      context.pushReplacement(Routes.welcome);
    }
  }
}

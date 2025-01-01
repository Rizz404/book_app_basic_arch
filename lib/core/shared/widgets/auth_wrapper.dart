import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAuthenticated = context.watch<AuthProvider>().isAuthenticated;

    // Cek apakah sedang di halaman register
    final String currentPath = GoRouterState.of(context).fullPath ?? '';
    final bool isRegisterPage = currentPath == '/sign-up';

    // Jika belum login dan bukan di halaman register, redirect ke login
    if (!isAuthenticated && !isRegisterPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.push(
          '/sign-in',
        ); // Menggunakan go alih-alih push untuk menghindari penumpukan history
      });

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return child;
  }
}

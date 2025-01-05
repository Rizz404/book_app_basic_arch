import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// todo: Fix ini kaga jelas
class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final String currentPath = GoRouterState.of(context).fullPath ?? '';
    final bool isRegisterPage = currentPath == '/sign-up';

    // * Tampilkan loading selama inisialisasi
    if (!authProvider.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // * Setelah inisialisasi selesai, cek autentikasi
    if (!authProvider.isAuthenticated && !isRegisterPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.push('/sign-in');
      });
    }

    return child;
  }
}

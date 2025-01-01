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
    final bool isAuthenticated = context.watch<AuthProvider>().isAuthenticated;

    final String currentPath = GoRouterState.of(context).fullPath ?? '';
    final bool isRegisterPage = currentPath == '/sign-up';

    if (!isAuthenticated && !isRegisterPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.push(
          '/sign-in',
        );
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

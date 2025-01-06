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
    final authProvider = context.watch<AuthProvider>();

    // Mengambil current path
    final String currentPath = GoRouterState.of(context).fullPath ?? '';

    // Daftar path yang diperbolehkan tanpa autentikasi
    final List<String> publicPaths = ['/sign-in', '/sign-up'];
    final bool isPublicPath = publicPaths.contains(currentPath);

    // Tampilkan loading selama inisialisasi
    if (!authProvider.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Setelah inisialisasi selesai, cek autentikasi
    if (!authProvider.isAuthenticated && !isPublicPath) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Pastikan tidak berada dalam proses navigasi
        if (!context.mounted) return;

        // Redirect ke login hanya jika bukan di public path
        context.push('/sign-in');
        return;
      });
    }

    return child;
  }
}

import 'package:book_app_basic_arch/feature/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScaffold extends StatelessWidget {
  final bool requireAuth;
  final Widget? fallbackWidget;
  final Widget body;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Drawer? drawer;
  final Widget? endDrawer;
  final BottomNavigationBar? bottomNavigationBar;
  final BottomSheet? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool? primary;
  final bool? extendBody;
  final bool? extendBodyBehindAppBar;

  const BaseScaffold({
    super.key,
    this.requireAuth = false,
    this.fallbackWidget,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary,
    this.extendBody,
    this.extendBodyBehindAppBar,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAuthenticated = context.watch<AuthProvider>().isAuthenticated;

    // * Jika screen tidak memerlukan auth, langsung tampilkan
    if (!requireAuth) {
      return _buildBaseLayout();
    }

    // * Jika perlu autentikasi tapi belum login, tampilkan loading
    if (!isAuthenticated) {
      return fallbackWidget ?? _defaultLoginRedirect(context);
    }

    // * Jika sudah login, tampilkan layout
    return _buildBaseLayout();
  }

  Widget _buildBaseLayout() {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary ?? true,
      extendBody: extendBody ?? false,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
    );
  }

  Widget _defaultLoginRedirect(BuildContext context) {
    // * Langsung redirect ke login screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed('/login');
    });

    // * Tampilkan loading selama proses redirect
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

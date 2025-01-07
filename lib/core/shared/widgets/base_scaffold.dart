import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  const BaseScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final userCredential = context.watch<AuthProvider>().userCredential;

    return Scaffold(
      body: SafeArea(
        child: body,
      ),
      floatingActionButton:
          userCredential != null && userCredential.role == 'ADMIN'
              ? floatingActionButton
              : null,
    );
  }
}

import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;

  const BaseScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: body,
      ),
    );
  }
}

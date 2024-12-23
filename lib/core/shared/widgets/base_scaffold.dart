import 'package:book_app_basic_arch/core/shared/widgets/styled_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseScaffold extends StatelessWidget {
  final StatefulNavigationShell statefulNavigationShell;

  const BaseScaffold({
    super.key,
    required this.statefulNavigationShell,
  });

  void _goBranch(int index) {
    statefulNavigationShell.goBranch(
      index,
      initialLocation: index == statefulNavigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: statefulNavigationShell,
      ),
      bottomNavigationBar: StyledNavigationBar(
        selectedIndex: statefulNavigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      ),
    );
  }
}

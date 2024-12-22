import 'package:flutter/material.dart';

class StyledBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color? backgroundColor;
  final double? elevation;

  const StyledBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.backgroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: selectedItemColor ?? Theme.of(context).primaryColor,
      unselectedItemColor: unselectedItemColor ?? Colors.grey,
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: elevation ?? 8.0,
      type: BottomNavigationBarType.fixed, // * Bisa diubah jadi shifting
    );
  }
}

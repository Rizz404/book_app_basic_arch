import 'package:flutter/material.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leadingIcon;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;

  const StyledAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.actions,
    this.backgroundColor,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: centerTitle,
      leading: leadingIcon,
      actions: actions,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      elevation: 4,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

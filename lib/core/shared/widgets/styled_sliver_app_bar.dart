import 'package:flutter/material.dart';

class StyledSliverAppBar extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? avatar;

  const StyledSliverAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "Hello",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          Text(
            subtitle ?? "Kintil",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        avatar ??
            CircleAvatar(
              radius: 20,
              child: Image.asset(
                'assets/images/splash-screen-logo.png',
              ),
            ),
        const SizedBox(width: 16),
      ],
    );
  }
}

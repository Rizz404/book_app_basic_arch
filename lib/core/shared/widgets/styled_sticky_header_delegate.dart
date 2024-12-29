import 'package:flutter/material.dart';

class StyledStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double? height;
  final Color? backgroundColor;

  StyledStickyHeaderDelegate({
    required this.child,
    this.height,
    this.backgroundColor,
  });

  @override
  double get minExtent => height ?? 0.0;

  @override
  double get maxExtent => height ?? kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: minExtent,
          maxHeight: maxExtent,
        ),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

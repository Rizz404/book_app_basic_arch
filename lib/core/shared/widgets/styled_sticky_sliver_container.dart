import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_header_delegate.dart';
import 'package:flutter/material.dart';

class StyledStickySliverContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const StyledStickySliverContainer({
    super.key,
    required this.child,
    this.height,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StyledStickyHeaderDelegate(
        height: height,
        backgroundColor: backgroundColor,
        child: Container(
          padding: padding,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

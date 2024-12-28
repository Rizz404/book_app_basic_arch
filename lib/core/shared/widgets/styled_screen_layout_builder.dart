import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:flutter/material.dart';

// * Pake sliver
class StyledScreenLayoutBuilder extends StatelessWidget {
  final Widget? sliverAppBar;
  final List<Widget> Function(BuildContext, ScrollController) builder;

  const StyledScreenLayoutBuilder({
    super.key,
    this.sliverAppBar,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final ScrollController controller = ScrollController();
          return CustomScrollView(
            controller: controller,
            slivers: [
              sliverAppBar ?? StyledSliverAppBar(),
              ...builder(context, controller),
            ],
          );
        },
      ),
    );
  }
}

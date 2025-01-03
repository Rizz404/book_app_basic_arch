import 'package:flutter/material.dart';

// * Pake sliver
class StyledScreenLayoutBuilder extends StatelessWidget {
  final Widget sliverAppBar;
  final List<Widget> Function(BuildContext, ScrollController) builder;

  const StyledScreenLayoutBuilder({
    super.key,
    required this.sliverAppBar,
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
              sliverAppBar,
              ...builder(context, controller),
            ],
          );
        },
      ),
    );
  }
}

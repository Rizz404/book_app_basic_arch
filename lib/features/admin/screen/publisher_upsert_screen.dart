import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class PublisherUpsertScreen extends StatefulWidget {
  final String? publisherId;

  const PublisherUpsertScreen({
    super.key,
    this.publisherId,
  });

  @override
  State<PublisherUpsertScreen> createState() => PublisherUpsertScreenState();
}

class PublisherUpsertScreenState extends State<PublisherUpsertScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: const StyledSliverAppBar(title: Text('Upsert publisher')),
        builder: (builder, controller) {
          return [];
        },
      ),
    );
  }
}

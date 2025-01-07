import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class BookUpsertScreen extends StatefulWidget {
  final String? bookId;

  const BookUpsertScreen({
    super.key,
    this.bookId,
  });

  @override
  State<BookUpsertScreen> createState() => _BookUpsertScreenState();
}

class _BookUpsertScreenState extends State<BookUpsertScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: const StyledSliverAppBar(title: Text('Upsert book')),
        builder: (builder, controller) {
          return [];
        },
      ),
    );
  }
}

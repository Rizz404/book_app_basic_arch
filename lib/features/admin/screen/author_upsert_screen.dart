import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class AuthorUpsertScreen extends StatefulWidget {
  final String? authorId;

  const AuthorUpsertScreen({
    super.key,
    this.authorId,
  });

  @override
  State<AuthorUpsertScreen> createState() => AuthorUpsertScreenState();
}

class AuthorUpsertScreenState extends State<AuthorUpsertScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: const StyledSliverAppBar(title: Text('Upsert author')),
        builder: (builder, controller) {
          return [];
        },
      ),
    );
  }
}

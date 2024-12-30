import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/author/enums/author_operation_type.dart';
import 'package:book_app_basic_arch/features/author/widgets/author_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorSearchResultScreen extends StatefulWidget {
  final String query;

  const AuthorSearchResultScreen({
    super.key,
    required this.query,
  });

  @override
  State<AuthorSearchResultScreen> createState() =>
      _AuthorSearchResultScreenState();
}

class _AuthorSearchResultScreenState extends State<AuthorSearchResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthorProvider>().searchAuthorsByName(name: widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(
          title: Text('Hasil Pencarian: ${widget.query}'),
        ),
        builder: (builder, controller) {
          return [
            Consumer<AuthorProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading(AuthorOperationType.searchAuthors)) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList.builder(
                    itemCount: provider.searchedAuthors.length,
                    itemBuilder: (context, index) {
                      final author = provider.searchedAuthors[index];
                      return AuthorTile(
                        authorModel: author,
                      );
                    },
                  ),
                );
              },
            ),
          ];
        },
      ),
    );
  }
}

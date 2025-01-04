import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_sliver_container.dart';
import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/author/enums/author_operation_type.dart';
import 'package:book_app_basic_arch/features/author/enums/author_screen_type.dart';
import 'package:book_app_basic_arch/features/author/widgets/author_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorScreen extends StatelessWidget {
  const AuthorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context
          .read<AuthorProvider>()
          .getAuthors(screen: AuthorScreenType.authors);
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(
          title: StyledSearchBarPlaceholder(),
        ),
        builder: (builder, controller) {
          return [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: StyledStickySliverContainer(
                height: 24,
                child: Text(
                  "Recommended",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: Consumer<AuthorProvider>(builder: (context, provider, _) {
                final authors = provider.getAuthorsForSpecificScreen(
                  AuthorScreenType.authors,
                );
                final isLoading =
                    provider.isLoading(AuthorOperationType.getAuthors);
                final errorMessage =
                    provider.getError(AuthorOperationType.getAuthors);

                if (isLoading) {
                  return SliverToBoxAdapter(child: const StyledLoadingState());
                }

                if (errorMessage != null) {
                  return SliverToBoxAdapter(
                    child: StyledErrorMessage(
                      errorMessage: errorMessage,
                      onRetry: () =>
                          context.read<AuthorProvider>().getAuthors(),
                    ),
                  );
                }

                if (authors.isEmpty) {
                  return SliverToBoxAdapter(
                      child: const StyledEmptyData(message: 'No books found'));
                }

                return SliverList.builder(
                  itemCount: authors.length,
                  itemBuilder: (context, index) {
                    final author = authors[index];

                    return AuthorTile(authorModel: author);
                  },
                );
              }),
            )
          ];
        },
      ),
    );
  }
}

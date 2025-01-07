import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_screen_type.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/genre/widgets/infinite_scroll_genre_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  Future<void> _fetchData(BuildContext context) async {
    context.read<GenreProvider>().getGenres(screen: GenreScreenType.genres);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData(context);
    });

    return RefreshIndicator(
      onRefresh: () => _fetchData(context),
      child: BaseScaffold(
        body: StyledScreenLayoutBuilder(
          sliverAppBar: const StyledSliverAppBar(
            title: StyledSearchBarPlaceholder(),
          ),
          builder: (builder, controller) {
            return [
              Consumer<GenreProvider>(
                builder: (context, genreProvider, _) {
                  final genres = genreProvider
                      .getGenresForSpecificScreen(GenreScreenType.genres);
                  final isLoadingGenres =
                      genreProvider.isLoading(GenreOperationType.getGenres);
                  final errorMessageGenres =
                      genreProvider.getError(GenreOperationType.getGenres);

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: InfiniteScrollGenreGrid(
                      genres: genres,
                      isLoading: isLoadingGenres,
                      errorMessage: errorMessageGenres,
                      emptyMessage: 'Genre is empty, try to add one admin!!',
                      scrollController: controller,
                      onGenreSelected: (genre) {
                        context.push('/genres/${genre.id}');
                      },
                      isInitialLoading: genreProvider.isInitialLoad(
                        GenreScreenType.genres,
                      ),
                      onLoadMore: () =>
                          genreProvider.loadMoreGenres(GenreScreenType.genres),
                      onRetry: () => genreProvider.getGenres(
                        screen: GenreScreenType.genres,
                      ),
                    ),
                  );
                },
              ),
            ];
          },
        ),
      ),
    );
  }
}

import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_sliver_container.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_screen_type.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/home/widgets/genre_list.dart';
import 'package:book_app_basic_arch/features/home/widgets/book_offer_carousel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleRefresh(BuildContext context) async {
    final bookProvider = context.read<BookProvider>();
    final genreProvider = context.read<GenreProvider>();

    await Future.wait([
      bookProvider.getBooks(
        screen: BookScreenType.home,
      ),
      genreProvider.getGenres(
        screen: GenreScreenType.home,
        refresh: true,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().getBooks(screen: BookScreenType.home);
      context.read<GenreProvider>().getGenres(screen: GenreScreenType.home);
    });

    final images = [
      "https://i.pinimg.com/236x/0f/a9/5a/0fa95a25260140bdfad97b20768ce254.jpg",
      "https://i.pinimg.com/236x/b7/69/a1/b769a1ee09bcc2343277bb6d76b6c328.jpg",
      "https://i.pinimg.com/736x/72/20/d7/7220d7d532cbf4cc3d6f3c71d3e34c2a.jpg"
    ];

    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      child: StyledScreenLayoutBuilder(
          sliverAppBar: StyledSliverAppBar(
            title: StyledSearchBarPlaceholder(
              hintText: "Hinted search text",
            ),
          ),
          builder: (context, controller) {
            return [
              // Carousel
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 24,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: [
                      BookOfferCarousel(
                        bannerImages: images,
                      ),
                    ],
                  ),
                ),
              ),

              // Sticky GenreList
              StyledStickySliverContainer(
                height: 64,
                padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                child: Consumer<GenreProvider>(
                  builder: (context, genreProvider, _) {
                    return GenreList(
                      genres: genreProvider.getGenresForSpecificScreen(
                        GenreScreenType.home,
                      ),
                      isLoading:
                          genreProvider.isLoading(GenreOperationType.getGenres),
                      errorMessage:
                          genreProvider.getError(GenreOperationType.getGenres),
                      onRetry: () => genreProvider.getGenres(),
                      onGenreSelected: (genreId) =>
                          context.push('/genres/$genreId'),
                    );
                  },
                ),
              ),

              // * BookGrid
              Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final books = bookProvider
                      .getBooksForSpecificScreen(BookScreenType.home);
                  final isLoadingBooks =
                      bookProvider.isLoading(BookOperationType.getBooks);
                  final errorMessageBooks =
                      bookProvider.getError(BookOperationType.getBooks);

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: InfiniteScrollBookGrid(
                      books: books,
                      isLoading: isLoadingBooks,
                      errorMessage: errorMessageBooks,
                      emptyMessage: 'Book is empty, try to add one admin!!',
                      scrollController: controller,
                      onBookSelected: (book) {
                        context.push('/books/${book.id}');
                      },
                      isInitialLoading: bookProvider.isInitialLoad(
                        BookScreenType.home,
                      ),
                      onLoadMore: () =>
                          bookProvider.loadMoreBooks(BookScreenType.home),
                      onRetry: () => bookProvider.getBooks(
                        screen: BookScreenType.home,
                      ),
                    ),
                  );
                },
              ),
            ];
          }),
    );
  }
}

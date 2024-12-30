import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_sliver_container.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/genre/enum_genre_operation.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_grid.dart';
import 'package:book_app_basic_arch/features/home/widgets/genre_list.dart';
import 'package:book_app_basic_arch/features/home/widgets/book_offer_carousel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().getBooks();
      context.read<GenreProvider>().getGenres();
    });

    final images = [
      "https://i.pinimg.com/236x/30/c2/10/30c210344bbbcde4d5542c02a0cb908b.jpg",
      "https://i.pinimg.com/236x/55/c3/b9/55c3b96dc1cc14a02f698796ed1dac7e.jpg",
      "https://i.pinimg.com/236x/9e/7c/46/9e7c469cdd4842b408ce3a09230b9b29.jpg"
    ];

    return StyledScreenLayoutBuilder(
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
                    genres: genreProvider.genres,
                    isLoading:
                        genreProvider.isLoading(EnumGenreOperation.getAll),
                    errorMessage:
                        genreProvider.getError(EnumGenreOperation.getAll),
                    onRetry: () => genreProvider.getGenres(),
                    onGenreSelected: (genreId) =>
                        context.push('/genres/$genreId'),
                  );
                },
              ),
            ),

            // BookGrid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: Consumer<BookProvider>(
                builder: (context, provider, _) {
                  final books =
                      provider.getBooksForSpecificScreen(BookScreenType.home);
                  final isLoading =
                      provider.isLoading(BookOperationType.getBooks);
                  final errorMessage =
                      provider.getError(BookOperationType.getBooks);

                  return SliverToBoxAdapter(
                    child: BookGrid(
                      books: books,
                      isLoading: isLoading,
                      errorMessage: errorMessage,
                      onRetry: () =>
                          provider.getBooks(screen: BookScreenType.home),
                      onBookSelected: (book) {
                        context.push('/books/${book.id}');
                      },
                    ),
                  );
                },
              ),
            ),
          ];
        });
  }
}

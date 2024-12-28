import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_sliver_container.dart';
import 'package:book_app_basic_arch/features/genre/enum_genre_operation.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/home/widgets/book_grid.dart';
import 'package:book_app_basic_arch/features/home/widgets/book_search_bar.dart';
import 'package:book_app_basic_arch/features/home/widgets/genre_list.dart';
import 'package:book_app_basic_arch/features/home/widgets/book_offer_carousel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enum_book_operation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final images = [
    "https://i.pinimg.com/236x/30/c2/10/30c210344bbbcde4d5542c02a0cb908b.jpg",
    "https://i.pinimg.com/236x/55/c3/b9/55c3b96dc1cc14a02f698796ed1dac7e.jpg",
    "https://i.pinimg.com/236x/9e/7c/46/9e7c469cdd4842b408ce3a09230b9b29.jpg"
  ];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  void handleSearchIconPressed() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
    });
    context.read<BookProvider>().getBooks();
  }

  void handleChange(String value) {
    setState(() {
      _isSearching = value.isNotEmpty;
    });
    if (value.isNotEmpty) {
      context.read<BookProvider>().searchBookByTitle(
            title: value.trim(),
          );
    } else {
      context.read<BookProvider>().getBooks();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().getBooks();
      context.read<GenreProvider>().getGenres();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StyledScreenLayoutBuilder(builder: (context, controller) {
      return [
        // Carousel
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                BookOfferCarousel(
                  bannerImages: images,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        // Sticky SearchBar
        StyledStickySliverContainer(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BookSearchBar(
            controller: _searchController,
            onIconPressed: handleSearchIconPressed,
            onChanged: handleChange,
          ),
        ),

        // Sticky GenreList
        StyledStickySliverContainer(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<GenreProvider>(
            builder: (context, genreProvider, _) {
              return GenreList(
                genres: genreProvider.genres,
                isLoading: genreProvider.isLoading(EnumGenreOperation.getAll),
                errorMessage: genreProvider.getError(EnumGenreOperation.getAll),
                onRetry: () => genreProvider.getGenres(),
                onGenreSelected: (genreId) => context.push('/genres/$genreId'),
              );
            },
          ),
        ),

        // BookGrid
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: Consumer<BookProvider>(
            builder: (context, bookProvider, _) {
              final books = _isSearching
                  ? bookProvider.searchedBooks
                  : bookProvider.books;

              return SliverToBoxAdapter(
                child: BookGrid(
                  books: books,
                  isLoading: bookProvider.isLoading(_isSearching
                      ? EnumBookOperation.search
                      : EnumBookOperation.getAll),
                  errorMessage: bookProvider.getError(_isSearching
                      ? EnumBookOperation.search
                      : EnumBookOperation.getAll),
                  onRetry: () => _isSearching
                      ? bookProvider.searchBookByTitle(
                          title: _searchController.text)
                      : bookProvider.getBooks(),
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

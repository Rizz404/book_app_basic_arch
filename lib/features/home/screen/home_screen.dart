import 'package:book_app_basic_arch/core/shared/widgets/styled_app_bar.dart';
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
    // * Reset ke tampilan semua buku
    context.read<BookProvider>().getBooks();
  }

  void handleChange(String value) {
    setState(() {
      _isSearching = value.isNotEmpty;
    });
    if (value.isNotEmpty) {
      // * Lakukan pencarian setelah user mengetik
      context.read<BookProvider>().searchBookByTitle(
            title: value.trim(),
          );
    } else {
      // * Tampilkan semua buku jika search kosong
      context.read<BookProvider>().getBooks();
    }
  }

  @override
  void initState() {
    super.initState();
    // * Ambil data buku saat screen pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // * Fetch both books and genres
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
    return Scaffold(
      appBar: StyledAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              'kontolodon',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          CircleAvatar(
            radius: 20,
            child: Image.asset(
              'assets/images/splash-screen-logo.png',
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              BookOfferCarousel(
                bannerImages: images,
              ),
              SizedBox(height: 24),

              BookSearchBar(
                controller: _searchController,
                onIconPressed: handleSearchIconPressed,
                onChanged: handleChange,
              ),
              SizedBox(height: 24),

              Consumer<GenreProvider>(
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
              SizedBox(height: 24),
              // * List Buku

              Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final books = _isSearching
                      ? bookProvider.searchedBooks
                      : bookProvider.books;

                  return BookGrid(
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
                      // Handle book selection
                      context.push('/books/${book.id}');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:book_app_basic_arch/core/shared/widgets/styled_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/home/widgets/genre_list_horizontal.dart';
import 'package:book_app_basic_arch/features/home/widgets/home_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enum_book_operation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Ambil data buku saat screen pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().getBooks();
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
            CircleAvatar(
              child: Image.asset(
                'assets/images/splash-screen-logo.png',
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 16),
            HomeCarousel(),
            SizedBox(height: 24),
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari buku...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _isSearching = false;
                          });
                          // Reset ke tampilan semua buku
                          context.read<BookProvider>().getBooks();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _isSearching = value.isNotEmpty;
                });
                if (value.isNotEmpty) {
                  // Lakukan pencarian setelah user mengetik
                  context.read<BookProvider>().searchBookByTitle(
                        title: value.trim(),
                      );
                } else {
                  // Tampilkan semua buku jika search kosong
                  context.read<BookProvider>().getBooks();
                }
              },
            ),
            SizedBox(height: 24),
            GenreListHorizontal(),
            SizedBox(height: 24),
            // List Buku
            Expanded(
              child: Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  return _buildBookContent(context, bookProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookContent(BuildContext context, BookProvider provider) {
    final isLoadingGetBooks = provider.isLoading(EnumBookOperation.getAll);
    final errorMessageGetBooks = provider.getError(EnumBookOperation.getAll);
    final isLoadingSearchedBooks = provider.isLoading(EnumBookOperation.search);
    final errorMessageSearchedBooks =
        provider.getError(EnumBookOperation.search);
    final books = _isSearching ? provider.searchedBooks : provider.books;

    if (isLoadingGetBooks || isLoadingSearchedBooks) {
      return const StyledLoadingState();
    }

    if (errorMessageGetBooks != null || errorMessageSearchedBooks != null) {
      return StyledErrorMessage(
        errorMessage: errorMessageGetBooks ??
            errorMessageSearchedBooks ??
            'Terjadi kesalahan saat fetch',
        onRetry: () => provider.searchBookByTitle(
          title: _searchController.text,
        ),
      );
    }

    if (books.isEmpty) {
      return const StyledEmptyData(message: 'No books found');
    }

    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    book.bookPictures![0].url,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        book.author.name,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: books.length,
    );
  }
}

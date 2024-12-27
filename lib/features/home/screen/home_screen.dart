import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';
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
      appBar: AppBar(
        title: const Text('Katalog Buku'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
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
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
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
          ),

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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85, // Rasio aspek kartu diubah agar lebih tinggi
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCard(
            bookModel: book,
            onTap: () => context.push('/books/${book.id}'),
          );
        },
        itemCount: books.length,
      ),
    );
  }
}

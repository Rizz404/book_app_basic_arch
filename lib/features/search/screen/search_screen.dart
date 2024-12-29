import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _handleIconPress() {
    _searchController.clear();
  }

  void _handleChange(String value) {
    final bookProvider = context.read<BookProvider>();

    if (value.isNotEmpty) {
      bookProvider.searchBookByTitle(title: value.trim());
    } else {
      bookProvider.searchedBooks.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StyledScreenLayoutBuilder(
      sliverAppBar: SliverAppBar(
        floating: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        pinned: true,
        elevation: 0,
        title: StyledSearchBar(
          controller: _searchController,
          onIconPressed: _handleIconPress,
          onChanged: _handleChange,
          hintText: "Cari buku, genre, author, atau publisher",
        ),
        expandedHeight: 80,
        toolbarHeight: 80,
      ),
      builder: (builder, controller) {
        return [
          Consumer<BookProvider>(builder: (context, provider, _) {
            return SliverList.builder(
                itemCount: provider.searchedBooks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => context.push('/books'),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    leading: Icon(Icons.search),
                    title: Text(provider.searchedBooks[index].title),
                  );
                });
          }),
        ];
      },
    );
  }
}

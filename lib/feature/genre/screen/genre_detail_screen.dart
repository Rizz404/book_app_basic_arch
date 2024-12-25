import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/feature/genre/enum_genre_operation.dart';
import 'package:book_app_basic_arch/feature/genre/genre_provider.dart';
import 'package:book_app_basic_arch/feature/genre/widgets/book_genre_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenreDetailScreen extends StatefulWidget {
  final String genreId;

  const GenreDetailScreen({super.key, required this.genreId});

  @override
  State<GenreDetailScreen> createState() => _GenreDetailScreenState();
}

class _GenreDetailScreenState extends State<GenreDetailScreen> {
  late ScrollController _scrollController;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GenreProvider>().getGenreById(widget.genreId);
    });
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_isCollapsed) {
      setState(() => _isCollapsed = true);
    } else if (_scrollController.offset <= 100 && _isCollapsed) {
      setState(() => _isCollapsed = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GenreProvider>(
        builder: (context, provider, _) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: _isCollapsed ? 60 : 200,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: _buildGenreHeader(context, provider),
                    background: _buildGenreDescription(context, provider),
                  ),
                ),
              ];
            },
            body: BookGenreList(scrollController: _scrollController),
          );
        },
      ),
    );
  }

  Widget _buildGenreHeader(BuildContext context, GenreProvider provider) {
    final genre = provider.genre;
    if (genre == null) return const Text('Genre');

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _isCollapsed ? 1.0 : 0.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          genre.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildGenreDescription(BuildContext context, GenreProvider provider) {
    final isLoadingGenre = provider.isLoading(EnumGenreOperation.getById);
    final errorMessageGenre = provider.getError(EnumGenreOperation.getById);
    final genre = provider.genre;

    if (isLoadingGenre) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessageGenre != null) {
      return StyledErrorMessage(errorMessage: errorMessageGenre);
    }

    if (genre == null) {
      return const Center(child: Text('No genres available.'));
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _isCollapsed ? 0.0 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              genre.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              genre.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

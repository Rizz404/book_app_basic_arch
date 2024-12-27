import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/genre/enum_genre_operation.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/genre/widgets/book_genre_list.dart';
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
  bool _isDescriptionVisible = true;

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
    if (_scrollController.offset > 50 && _isDescriptionVisible) {
      setState(() => _isDescriptionVisible = false);
    } else if (_scrollController.offset <= 50 && !_isDescriptionVisible) {
      setState(() => _isDescriptionVisible = true);
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
      appBar: AppBar(
        title: const Text('Genre'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<GenreProvider>(
            builder: (context, provider, _) {
              return _buildGenreContent(context, provider);
            },
          ),
          Expanded(
            child: BookGenreList(
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreContent(BuildContext context, GenreProvider provider) {
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

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // * Genre Name - Selalu terlihat
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              genre.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          // * Genre Description - Menghilang saat scroll
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: _isDescriptionVisible
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: Text(
                      genre.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                          ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

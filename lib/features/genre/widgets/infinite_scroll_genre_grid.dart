import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:book_app_basic_arch/features/genre/widgets/genre_card.dart';
import 'package:book_app_basic_arch/features/genre/widgets/genre_grid_skeleton.dart';
import 'package:flutter/material.dart';

class InfiniteScrollGenreGrid extends StatefulWidget {
  final List<GenreModel> genres;
  final bool isLoading;
  final String? errorMessage;
  final Function()? onRetry;
  final Function() onLoadMore;
  final Function(GenreModel) onGenreSelected;
  final ScrollController scrollController;

  const InfiniteScrollGenreGrid({
    super.key,
    required this.genres,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
    required this.onLoadMore,
    required this.onGenreSelected,
    required this.scrollController,
  });

  @override
  State<InfiniteScrollGenreGrid> createState() =>
      _InfiniteScrollGenreGridState();
}

class _InfiniteScrollGenreGridState extends State<InfiniteScrollGenreGrid> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom && !widget.isLoading) {
      widget.onLoadMore();
    }
  }

  bool get _isBottom {
    if (!widget.scrollController.hasClients) {
      return false;
    }
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const GenreGridSkeleton();
    }

    if (widget.errorMessage != null) {
      return SliverFillRemaining(
        child: StyledErrorMessage(
          errorMessage: widget.errorMessage!,
          onRetry: widget.onRetry,
        ),
      );
    }

    if (widget.genres.isEmpty) {
      return const SliverFillRemaining(
        child: StyledEmptyData(message: 'No genres found'),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        // Grid utama dengan data buku
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final genre = widget.genres[index];
              return GenreCard(
                key: Key(genre.id),
                genreModel: genre,
                onTap: () => widget.onGenreSelected(genre),
              );
            },
            childCount: widget.genres.length,
          ),
        ),

        // Skeleton loader untuk pagination
        if (widget.isLoading) const GenreGridSkeleton(),
      ],
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}

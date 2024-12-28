import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/genre/genre_model.dart';
import 'package:flutter/material.dart';

class GenreList extends StatelessWidget {
  final List<GenreModel> genres;
  final bool isLoading;
  final String? errorMessage;
  final Function()? onRetry;
  final Function(String) onGenreSelected;

  const GenreList({
    super.key,
    required this.genres,
    required this.isLoading,
    required this.onGenreSelected,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return StyledErrorMessage(
        errorMessage: errorMessage!,
        onRetry: onRetry,
      );
    }

    if (genres.isEmpty) {
      return const Center(child: Text('No genres available.'));
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 1),
        ),
      ),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => onGenreSelected(genres[index].id),
                child: Text(genres[index].name),
              ),
            ),
          );
        },
      ),
    );
  }
}

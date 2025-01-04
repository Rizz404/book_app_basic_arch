import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:flutter/material.dart';

class GenreListHorizontal extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<GenreModel> genres;
  final Function()? onRetry;
  final Function(String) onGenreSelected;

  const GenreListHorizontal({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.genres,
    required this.onRetry,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 120,
        child: Center(
          child: StyledLoadingState(),
        ),
      );
    }

    if (errorMessage != null) {
      return SizedBox(
        height: 120,
        child: Center(
          child: StyledErrorMessage(
            errorMessage: errorMessage!,
            onRetry: onRetry,
          ),
        ),
      );
    }

    if (genres.isEmpty) {
      return const SizedBox(
        height: 120,
        child: Center(
          child: StyledEmptyData(message: 'No similar genres found'),
        ),
      );
    }

    return SizedBox(
      height: 92,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          final genre = genres[index];

          return GestureDetector(
            onTap: () => onGenreSelected(genre.id),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(genre.picture),
                ),
                SizedBox(height: 8),
                Text(
                  genre.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:book_app_basic_arch/features/home/widgets/genre_list_skeleton.dart';
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
      return GenreListSkeleton();
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
          horizontal: BorderSide(width: 1, color: Color(0xE9BBB280)),
        ),
      ),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.center,
            child: TextButton(
              child: Text(
                genres[index].name,
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              onPressed: () => onGenreSelected(genres[index].id),
            ),
          );
        },
      ),
    );
  }
}

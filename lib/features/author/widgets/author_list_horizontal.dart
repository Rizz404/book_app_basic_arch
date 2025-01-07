import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:flutter/material.dart';

class AuthorListHorizontal extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<AuthorModel> authors;
  final Function()? onRetry;
  final Function(String) onAuthorSelected;

  const AuthorListHorizontal({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.authors,
    required this.onRetry,
    required this.onAuthorSelected,
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

    if (authors.isEmpty) {
      return const SizedBox(
        height: 120,
        child: Center(
          child: StyledEmptyData(message: 'No similar authors found'),
        ),
      );
    }

    return SizedBox(
      height: 92,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: authors.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final author = authors[index];

          return GestureDetector(
            onTap: () => onAuthorSelected(author.id),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(author.profilePicture),
                ),
                const SizedBox(height: 8),
                Text(
                  author.name,
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

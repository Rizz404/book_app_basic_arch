import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:flutter/material.dart';

class PublisherListHorizontal extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<PublisherModel> publishers;
  final Function()? onRetry;
  final Function(String) onPublisherSelected;

  const PublisherListHorizontal({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.publishers,
    required this.onRetry,
    required this.onPublisherSelected,
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

    if (publishers.isEmpty) {
      return const SizedBox(
        height: 120,
        child: Center(
          child: StyledEmptyData(message: 'No similar publishers found'),
        ),
      );
    }

    return SizedBox(
      height: 92,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: publishers.length,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          final publisher = publishers[index];

          return GestureDetector(
            onTap: () => onPublisherSelected(publisher.id),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(publisher.picture),
                ),
                SizedBox(height: 8),
                Text(
                  publisher.name,
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

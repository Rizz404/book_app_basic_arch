import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_sliver_container.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_screen_type.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublisherScreen extends StatelessWidget {
  const PublisherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context
          .read<PublisherProvider>()
          .getPublishers(screen: PublisherScreenType.publishers);
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(
          title: StyledSearchBarPlaceholder(),
        ),
        builder: (builder, controller) {
          return [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: StyledStickySliverContainer(
                height: 24,
                child: Text(
                  "Recommended",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver:
                  Consumer<PublisherProvider>(builder: (context, provider, _) {
                final publishers = provider.getPublishersForSpecificScreen(
                  PublisherScreenType.publishers,
                );
                final isLoading =
                    provider.isLoading(PublisherOperationType.getPublishers);
                final errorMessage =
                    provider.getError(PublisherOperationType.getPublishers);

                if (isLoading) {
                  return SliverToBoxAdapter(child: const StyledLoadingState());
                }

                if (errorMessage != null) {
                  return SliverToBoxAdapter(
                    child: StyledErrorMessage(
                      errorMessage: errorMessage,
                      onRetry: () =>
                          context.read<PublisherProvider>().getPublishers(),
                    ),
                  );
                }

                if (publishers.isEmpty) {
                  return SliverToBoxAdapter(
                      child: const StyledEmptyData(message: 'No books found'));
                }

                return SliverList.builder(
                  itemCount: publishers.length,
                  itemBuilder: (context, index) {
                    final publisher = publishers[index];

                    return PublisherTile(publisherModel: publisher);
                  },
                );
              }),
            )
          ];
        },
      ),
    );
  }
}

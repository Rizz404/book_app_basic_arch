import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_sliver_container.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_screen_type.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/infinite_scroll_publisher_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        sliverAppBar: const StyledSliverAppBar(
          title: StyledSearchBarPlaceholder(),
        ),
        builder: (builder, controller) {
          return [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: StyledStickySliverContainer(
                height: 24,
                child: Text(
                  "Publishers",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Consumer<PublisherProvider>(
                builder: (context, publisherProvider, _) {
              final publishers =
                  publisherProvider.getPublishersForSpecificScreen(
                PublisherScreenType.publishers,
              );
              final isLoadingPublisher = publisherProvider
                  .isLoading(PublisherOperationType.getPublishers);
              final errorMessage = publisherProvider
                  .getError(PublisherOperationType.getPublishers);

              if (errorMessage != null) {
                return SliverToBoxAdapter(
                  child: StyledErrorMessage(
                    errorMessage: errorMessage,
                    onRetry: () =>
                        context.read<PublisherProvider>().getPublishers(),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: InfiniteScrollPublisherList(
                  publishers: publishers,
                  isLoading: isLoadingPublisher,
                  errorMessage: errorMessage,
                  emptyMessage: 'No publishers found, add some admin!!',
                  scrollController: controller,
                  onPublisherSelected: (publisher) {
                    context.push('/publishers/${publisher.id}');
                  },
                  isInitialLoading: publisherProvider
                      .isInitialLoad(PublisherScreenType.publishers),
                  onLoadMore: () => publisherProvider
                      .loadMorePublishers(PublisherScreenType.publishers),
                  onRetry: () => publisherProvider.getPublishers(
                    screen: PublisherScreenType.publishers,
                  ),
                ),
              );
            })
          ];
        },
      ),
    );
  }
}

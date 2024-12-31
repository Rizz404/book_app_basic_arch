import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_screen_type.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_list_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PublisherDetailScreen extends StatelessWidget {
  final String publisherId;

  const PublisherDetailScreen({
    super.key,
    required this.publisherId,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final publisherProvider = context.read<PublisherProvider>();
      final bookProvider = context.read<BookProvider>();

      publisherProvider.getPublisherById(publisherId);
      publisherProvider.getPublishers(
          screen: PublisherScreenType.publisherDetail);

      bookProvider.updateFilterForSpecificScreen(
        BookScreenType.publisherDetail,
        bookProvider
            .getFilterForSpecificScreen(BookScreenType.publisherDetail)
            .copyWith(publisherId: publisherId),
      );
      bookProvider.getBooks(screen: BookScreenType.publisherDetail);
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        builder: (builder, controller) {
          return [
            SliverToBoxAdapter(
              child: Consumer<PublisherProvider>(
                builder: (context, provider, _) {
                  final isLoadingPublisher = provider
                      .isLoading(PublisherOperationType.getPublisherById);
                  final errorMessagePublisher = provider
                      .getError(PublisherOperationType.getPublisherById);
                  final publisher = provider.publisher;

                  final isLoadingPublishers =
                      provider.isLoading(PublisherOperationType.getPublishers);
                  final errorMessagePublishers =
                      provider.getError(PublisherOperationType.getPublishers);
                  final publishers = provider.getPublishersForSpecificScreen(
                      PublisherScreenType.publisherDetail);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPublisherCard(
                        context,
                        isLoadingPublisher,
                        errorMessagePublisher,
                        publisher,
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Similar Publishers",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(height: 16),
                      PublisherListHorizontal(
                        isLoading: isLoadingPublishers,
                        errorMessage: errorMessagePublishers,
                        publishers: publishers,
                        onRetry: () => provider.getPublishers(
                            screen: PublisherScreenType.publisherDetail),
                        onPublisherSelected: (publisherId) => context.push(
                          '/publishers/$publisherId',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                top: 32,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Our Books",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            Consumer<BookProvider>(
              builder: (context, provider, _) {
                final isLoading =
                    provider.isLoading(BookOperationType.getBooks);
                final errorMessage =
                    provider.getError(BookOperationType.getBooks);
                final books = provider
                    .getBooksForSpecificScreen(BookScreenType.publisherDetail);

                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: InfiniteScrollBookGrid(
                    books: books,
                    isLoading: isLoading,
                    errorMessage: errorMessage,
                    onLoadMore: () => provider.loadMoreBooks(
                        screen: BookScreenType.publisherDetail),
                    onBookSelected: (book) {
                      context.push('/books/${book.id}');
                    },
                    scrollController: controller,
                  ),
                );
              },
            ),
          ];
        },
      ),
    );
  }

  Widget _buildPublisherCard(
    BuildContext context,
    bool isLoading,
    String? errorMessage,
    PublisherModel? publisher,
  ) {
    if (isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: StyledLoadingState(),
        ),
      );
    }

    if (errorMessage != null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: StyledErrorMessage(
            errorMessage: errorMessage,
            onRetry: () {
              context.read<PublisherProvider>().getPublisherById(publisherId);
            },
          ),
        ),
      );
    }

    if (publisher == null) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: StyledEmptyData(message: 'Publisher not found'),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  publisher.picture,
                  fit: BoxFit.cover,
                  width: 120,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * Name
                    Text(
                      publisher.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 6),

                    Text(
                      publisher.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                    ),
                    SizedBox(height: 6),

                    Row(
                      children: [
                        Icon(Icons.email_outlined),
                        SizedBox(width: 8),
                        Text(
                          publisher.email,
                          style: Theme.of(context).textTheme.bodySmall,
                          softWrap: true,
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.web_outlined),
                        SizedBox(width: 8),
                        Text(
                          publisher.website.join(", "),
                          style: Theme.of(context).textTheme.bodySmall,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_outline),
                      Text(
                        '${publisher.followerCount}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Followers',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              StyledButton(
                onPressed: () {},
                child: Text('Follow'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

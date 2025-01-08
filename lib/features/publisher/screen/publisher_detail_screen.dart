import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_screen_type.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_list_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PublisherDetailScreen extends StatefulWidget {
  final String publisherId;

  const PublisherDetailScreen({
    super.key,
    required this.publisherId,
  });

  @override
  State<PublisherDetailScreen> createState() => _PublisherDetailScreenState();
}

class _PublisherDetailScreenState extends State<PublisherDetailScreen> {
  Future<void> _fetchData() async {
    final publisherProvider = context.read<PublisherProvider>();
    final bookProvider = context.read<BookProvider>();

    await publisherProvider.getPublisherById(widget.publisherId);
    await publisherProvider.getPublishers(
        screen: PublisherScreenType.publisherDetail);

    final currentFilter = bookProvider.getFilterForSpecificScreen(
      BookScreenType.publisherDetail,
    );

    bookProvider.updateFilterForSpecificScreen(
      BookScreenType.publisherDetail,
      currentFilter.copyWith(publisherId: widget.publisherId, page: 1),
    );

    await bookProvider.getBooks(screen: BookScreenType.publisherDetail);
  }

  @override
  void didUpdateWidget(covariant PublisherDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.publisherId != widget.publisherId) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          _fetchData();
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  Future<void> _deletePublisherById() async {
    try {
      await context
          .read<PublisherProvider>()
          .deletePublisherById(widget.publisherId);

      if (!mounted) return;

      final error = context
          .read<PublisherProvider>()
          .getError(PublisherOperationType.deletePublisherById);
      if (error == null) {
        // Sukses hapus, kembali ke halaman sebelumnya
        context.pop();

        // Optional: Tampilkan snackbar konfirmasi
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Publisher berhasil dihapus')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus publisher: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.edit,
                          color: Theme.of(context).primaryColor),
                      title: const Text('Edit Publisher'),
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/publishers/edit/${widget.publisherId}');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.delete,
                          color: Theme.of(context).colorScheme.error),
                      title: const Text('Delete Publisher'),
                      onTap: () {
                        Navigator.pop(context);
                        _showDeleteConfirmation();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.more_vert), // Ikon untuk membuka BottomSheet
      ),
      body: RefreshIndicator(
        onRefresh: () => _fetchData(),
        child: StyledScreenLayoutBuilder(
          sliverAppBar: const StyledSliverAppBar(
            title: StyledSearchBarPlaceholder(
              hintText: "Hinted search text",
            ),
          ),
          builder: (builder, controller) {
            return [
              SliverToBoxAdapter(
                child: Consumer<PublisherProvider>(
                  builder: (context, provider, _) {
                    final isLoadingPublisher = provider
                        .isLoading(PublisherOperationType.getPublisherById);
                    final errorMessagePublisher = provider
                        .getError(PublisherOperationType.getPublisherById);
                    final publisher =
                        provider.getPublisherByIdFromCache(widget.publisherId);

                    final isLoadingPublishers = provider
                        .isLoading(PublisherOperationType.getPublishers);
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
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Similar Publishers",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 16),
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
                padding: const EdgeInsets.only(
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
                builder: (context, bookProvider, _) {
                  final books = bookProvider.getBooksForSpecificScreen(
                      BookScreenType.publisherDetail);
                  final isLoadingBooks =
                      bookProvider.isLoading(BookOperationType.getBooks);
                  final errorMessageBooks =
                      bookProvider.getError(BookOperationType.getBooks);

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: InfiniteScrollBookGrid(
                      books: books,
                      isLoading: isLoadingBooks,
                      errorMessage: errorMessageBooks,
                      emptyMessage: 'Book is empty, try to add one admin!!',
                      scrollController: controller,
                      onBookSelected: (book) {
                        context.push('/books/${book.id}');
                      },
                      isInitialLoading: bookProvider.isInitialLoad(
                        BookScreenType.publisherDetail,
                      ),
                      onLoadMore: () => bookProvider
                          .loadMoreBooks(BookScreenType.publisherDetail),
                      onRetry: () => bookProvider.getBooks(
                        screen: BookScreenType.publisherDetail,
                      ),
                    ),
                  );
                },
              ),
            ];
          },
        ),
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
              context
                  .read<PublisherProvider>()
                  .getPublisherById(widget.publisherId);
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * Name
                    Text(
                      publisher.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 6),

                    Text(
                      publisher.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                    ),
                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(Icons.email_outlined),
                        const SizedBox(width: 8),
                        Text(
                          publisher.email,
                          style: Theme.of(context).textTheme.bodySmall,
                          softWrap: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.web_outlined),
                        const SizedBox(width: 8),
                        Text(
                          publisher.website.join(", "),
                          style: Theme.of(context).textTheme.bodySmall,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person_outline),
                      Text(
                        '${publisher.followerCount}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Followers',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              StyledButton(
                onPressed: () {},
                child: const Text('Follow'),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Publisher'),
        content: const Text(
            'Apakah Anda yakin ingin menghapus publisher ini? Aksi ini tidak dapat dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (shouldDelete ?? false) {
      await _deletePublisherById();
    }
  }
}

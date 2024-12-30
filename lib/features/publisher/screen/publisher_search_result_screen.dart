import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublisherSearchResultScreen extends StatefulWidget {
  final String query;

  const PublisherSearchResultScreen({
    super.key,
    required this.query,
  });

  @override
  State<PublisherSearchResultScreen> createState() =>
      _PublisherSearchResultScreenState();
}

class _PublisherSearchResultScreenState
    extends State<PublisherSearchResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<PublisherProvider>()
          .searchPublishersByName(name: widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(
          title: Text('Hasil Pencarian: ${widget.query}'),
        ),
        builder: (builder, controller) {
          return [
            Consumer<PublisherProvider>(
              builder: (context, provider, _) {
                if (provider
                    .isLoading(PublisherOperationType.searchPublishers)) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final publisher = provider.searchedPublishers[index];
                        return PublisherTile(
                          publisherModel: publisher,
                        );
                      },
                      childCount: provider.searchedPublishers.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                  ),
                );
              },
            ),
          ];
        },
      ),
    );
  }
}

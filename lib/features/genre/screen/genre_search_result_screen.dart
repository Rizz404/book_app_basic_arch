import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/widgets/genre_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GenreSearchResultScreen extends StatefulWidget {
  final String query;

  const GenreSearchResultScreen({
    super.key,
    required this.query,
  });

  @override
  State<GenreSearchResultScreen> createState() =>
      _GenreSearchResultScreenState();
}

class _GenreSearchResultScreenState extends State<GenreSearchResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GenreProvider>().searchGenresByName(name: widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(
          title: Text(
            'Hasil Pencarian: ${widget.query}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        builder: (builder, controller) {
          return [
            Consumer<GenreProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading(GenreOperationType.searchGenres)) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final genre = provider.searchedGenres[index];
                        return GenreCard(
                          genreModel: genre,
                          onTap: () => context.push('/genres/${genre.id}'),
                        );
                      },
                      childCount: provider.searchedGenres.length,
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

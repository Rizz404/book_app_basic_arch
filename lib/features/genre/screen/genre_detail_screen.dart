import 'package:book_app_basic_arch/core/helpers/enum_screen_type.dart';
import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_sliver_container.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/features/genre/enum_genre_operation.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GenreDetailScreen extends StatelessWidget {
  final String genreId;

  const GenreDetailScreen({
    super.key,
    required this.genreId,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // * Kalo stateles itu pakenya read aja
      final genreProvider = context.read<GenreProvider>();
      final bookProvider = context.read<BookProvider>();

      genreProvider.getGenreById(genreId);

      bookProvider.updateFilterForSpecificScreen(
        ScreenType.genreDetail,
        bookProvider
            .getFilterForSpecificScreen(ScreenType.genreDetail)
            .copyWith(genreId: genreId),
      );

      bookProvider.getBooks(screen: ScreenType.genreDetail);
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(builder: (context, controller) {
        return [
          StyledStickySliverContainer(
            backgroundColor: Colors.grey.shade500,
            height: 72,
            child: Consumer<GenreProvider>(
              builder: (builder, provider, _) {
                final isLoadingGenre =
                    provider.isLoading(EnumGenreOperation.getById);
                final errorMessageGenre =
                    provider.getError(EnumGenreOperation.getById);
                final genre = provider.genre;

                if (isLoadingGenre) {
                  return StyledLoadingState();
                }

                if (errorMessageGenre != null) {
                  return StyledErrorMessage(errorMessage: errorMessageGenre);
                }

                if (genre == null) {
                  return StyledEmptyData(message: 'Genre not found');
                }

                return ListTile(
                  title: Text(genre.name),
                  subtitle: Text(
                    genre.description,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: Consumer<BookProvider>(
              builder: (context, bookProvider, _) {
                final books = bookProvider.getBooksForSpecificScreen(
                  ScreenType.genreDetail,
                );

                return SliverToBoxAdapter(
                  child: BookGrid(
                    books: books,
                    isLoading: bookProvider.isLoading(EnumBookOperation.getAll),
                    errorMessage:
                        bookProvider.getError(EnumBookOperation.getAll),
                    onRetry: () => bookProvider.getBooks(),
                    onBookSelected: (book) {
                      context.push('/books/${book.id}');
                    },
                  ),
                );
              },
            ),
          ),
        ];
      }),
    );
  }
}

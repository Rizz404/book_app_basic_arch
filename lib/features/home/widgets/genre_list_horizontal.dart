import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/genre/enum_genre_operation.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GenreListHorizontal extends StatelessWidget {
  const GenreListHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GenreProvider>().getGenres();
    });

    return Consumer<GenreProvider>(builder: (context, provider, _) {
      final isLoadingGenres = provider.isLoading(EnumGenreOperation.getAll);
      final errorMessageGenres = provider.getError(EnumGenreOperation.getAll);
      final genres = provider.genres;

      if (isLoadingGenres) {
        return Center(child: CircularProgressIndicator());
      }

      if (errorMessageGenres != null) {
        return StyledErrorMessage(errorMessage: errorMessageGenres);
      }

      if (genres.isEmpty) {
        return Center(child: Text('No genres available.'));
      } else {
        return Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                width: 1,
              ),
            ),
          ),
          height: 40,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTap: () =>
                            context.push('/genres/${genres[index].id}'),
                        child: Text(genres[index].name)),
                  ),
                );
              }),
        );
      }
    });
  }
}

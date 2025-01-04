import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_screen_type.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/genre/widgets/genre_card.dart';
import 'package:book_app_basic_arch/features/genre/widgets/genre_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GenreProvider>().getGenres(screen: GenreScreenType.genres);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const GenreForm(),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Genres'),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<GenreProvider>().getGenres(),
        child: Consumer<GenreProvider>(
          builder: (context, provider, _) {
            final isLoadingGenres =
                provider.isLoading(GenreOperationType.getGenres);
            final errorMessageGenres =
                provider.getError(GenreOperationType.getGenres);
            final genres = provider.getGenresForSpecificScreen(
              GenreScreenType.genres,
            );

            if (isLoadingGenres) {
              return StyledLoadingState();
            }

            // * Menampilkan pesan error jika ada kesalahan
            if (errorMessageGenres != null) {
              return StyledErrorMessage(errorMessage: errorMessageGenres);
            }

            // * Menampilkan data genres jika berhasil di-fetch

            if (genres.isEmpty) {
              return Center(child: Text('No genres available.'));
            }

            return SliverToBoxAdapter(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  return GenreCard(
                    genreModel: genre,
                    onTap: () {
                      context.push('/genres/${genre.id}');
                    },
                  );
                },
                itemCount: genres.length,
              ),
            );
          },
        ),
      ),
    );
  }
}

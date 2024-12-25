import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/feature/genre/enum_genre_operation.dart';
import 'package:book_app_basic_arch/feature/genre/genre_provider.dart';
import 'package:book_app_basic_arch/feature/genre/widgets/genre_card.dart';
import 'package:book_app_basic_arch/feature/genre/widgets/genre_form.dart';
import 'package:flutter/material.dart';
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
      context.read<GenreProvider>().getGenres();
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
                provider.isLoading(EnumGenreOperation.getAll);
            final errorMessageGenres =
                provider.getError(EnumGenreOperation.getAll);
            final genres = provider.genres;

            if (isLoadingGenres) {
              return Center(child: CircularProgressIndicator());
            }

            // * Menampilkan pesan error jika ada kesalahan
            if (errorMessageGenres != null) {
              return StyledErrorMessage(errorMessage: errorMessageGenres);
            }

            // * Menampilkan data genres jika berhasil di-fetch

            if (genres.isEmpty) {
              return Center(child: Text('No genres available.'));
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  return GenreCard(genre: genre);
                },
                itemCount: genres.length,
              );
            }
          },
        ),
      ),
    );
  }
}

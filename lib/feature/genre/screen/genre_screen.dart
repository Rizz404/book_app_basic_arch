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
      body: Consumer<GenreProvider>(
        builder: (context, genreProvider, child) {
          Widget content;

          if (genreProvider.isLoadingGetGenres) {
            return content = Center(child: CircularProgressIndicator());
          }

          // * Menampilkan pesan error jika ada kesalahan
          if (genreProvider.errorMessageGetGenres != null) {
            return content = Center(
              child: Text(
                genreProvider.errorMessageGetGenres!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // * Menampilkan data genres jika berhasil di-fetch

          final genres = genreProvider.genres;
          if (genres.isEmpty) {
            content = const Center(child: Text('No genres available.'));
          } else {
            return content = GridView.builder(
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

          // * Wrap dengan RefreshIndicator dan Stack untuk loading indicator
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () => context.read<GenreProvider>().getGenres(),
                child: content,
              ),
              if (genreProvider.isLoadingGetGenres)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}

import 'package:book_app_basic_arch/feature/genre/genre_model.dart';
import 'package:book_app_basic_arch/feature/genre/genre_provider.dart';
import 'package:book_app_basic_arch/feature/genre/screen/genre_screen.dart';
import 'package:book_app_basic_arch/feature/genre/widgets/genre_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenreDetailScreen extends StatefulWidget {
  final String genreId;

  const GenreDetailScreen({super.key, required this.genreId});

  @override
  State<GenreDetailScreen> createState() => _GenreDetailScreenState();
}

class _GenreDetailScreenState extends State<GenreDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GenreProvider>().getGenreById(widget.genreId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final genreProvider = context.read<GenreProvider>();
          final genre = genreProvider.genre;

          if (genre != null) {
            showDialog(
              context: context,
              builder: (context) => GenreForm(
                updateGenreModel: UpdateGenreModel(
                  id: genre.id,
                  name: genre.name,
                  description: genre.description,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Genre not loaded yet.')),
            );
          }
        },
        child: Icon(Icons.edit),
      ),
      body: Consumer<GenreProvider>(
        builder: (context, genreProvider, Widget? child) {
          Widget content;

          if (genreProvider.isLoadingGetGenreById) {
            return content = Center(child: CircularProgressIndicator());
          }

          // * Menampilkan pesan error jika ada kesalahan
          if (genreProvider.errorMessageGetGenreById != null) {
            return content = Center(
              child: Text(
                genreProvider.errorMessageGetGenreById!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final genre = genreProvider.genre;
          if (genre == null) {
            content = const Center(child: Text('No genres available.'));
          } else {
            content = Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          genre.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.menu_book_outlined,
                        size: 20,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.6),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // * Description
                  Text(
                    genre.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text(
                                'Are you sure you want to delete this genre?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Tutup dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<GenreProvider>()
                                      .deleteGenre(widget.genreId);
                                  Navigator.of(context).pop(); // Tutup dialog
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GenreScreen()),
                                  );
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          }

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

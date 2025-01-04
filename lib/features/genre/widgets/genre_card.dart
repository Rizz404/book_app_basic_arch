import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GenreCard extends StatelessWidget {
  final GenreModel genreModel;
  final VoidCallback? onTap;

  const GenreCard({
    super.key,
    required this.genreModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.push('/genres/${genreModel.id}'),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Background image with dark overlay
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(genreModel.picture),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            // Genre name at bottom left
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                genreModel.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

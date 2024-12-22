import 'package:flutter/material.dart';

class AuthorCard extends StatelessWidget {
  final String name;
  final String biography;
  final String birthDate;
  final String? deathDate;
  final String profilePicture;
  final VoidCallback? onTap;

  const AuthorCard({
    super.key,
    required this.name,
    required this.biography,
    required this.birthDate,
    this.deathDate,
    required this.profilePicture,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Profile Picture
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  profilePicture,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 80);
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Author Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Author Name
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Dates (Birth - Death)
                    Text(birthDate),
                    const SizedBox(height: 8),
                    // Biography (limited)
                    Text(
                      biography,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

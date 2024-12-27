import 'package:book_app_basic_arch/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final UserWithProfileModel userWithProfileModel;
  final VoidCallback? onTap;

  const ProfileCard({
    super.key,
    required this.userWithProfileModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  userWithProfileModel.profilePicture,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 80);
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Profile Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Name
                    Text(
                      userWithProfileModel.username,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Dates (Birth - Death)
                    Text(userWithProfileModel.email),
                    const SizedBox(height: 8),
                    // Biography (limited)
                    Text(
                      userWithProfileModel.userProfile?.bio ?? '',
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

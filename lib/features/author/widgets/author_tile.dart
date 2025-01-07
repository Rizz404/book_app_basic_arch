import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthorTile extends StatelessWidget {
  final AuthorModel authorModel;
  final VoidCallback? onTap;

  const AuthorTile({
    super.key,
    required this.authorModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.push('/authors/${authorModel.id}'),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              authorModel.profilePicture,
            ),
          ),
          title: Text(
            authorModel.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            maxLines: 2,
            authorModel.biography,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ),
      ),
    );
  }
}

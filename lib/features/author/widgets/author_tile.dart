import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:flutter/material.dart';

class AuthorTile extends StatelessWidget {
  final AuthorModel authorModel;

  const AuthorTile({
    super.key,
    required this.authorModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
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
    );
  }
}

import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PublisherTile extends StatelessWidget {
  final PublisherModel publisherModel;
  final VoidCallback? onTap;

  const PublisherTile({
    super.key,
    required this.publisherModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.push('/publishers/${publisherModel.id}'),
      child: Card(
        margin: EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              publisherModel.picture,
            ),
          ),
          title: Text(
            publisherModel.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            maxLines: 2,
            publisherModel.description,
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

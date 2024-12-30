import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:flutter/material.dart';

class PublisherTile extends StatelessWidget {
  final PublisherModel publisherModel;

  const PublisherTile({
    super.key,
    required this.publisherModel,
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
    );
  }
}

import 'package:book_app_basic_arch/features/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_card.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublisherDetailScreen extends StatefulWidget {
  final String publisherId;

  const PublisherDetailScreen({super.key, required this.publisherId});

  @override
  State<PublisherDetailScreen> createState() => _PublisherDetailScreenState();
}

class _PublisherDetailScreenState extends State<PublisherDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PublisherProvider>().getPublisherById(widget.publisherId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final publisherProvider = context.read<PublisherProvider>();
          final publisher = publisherProvider.publisher;

          if (publisher != null) {
            showDialog(
              context: context,
              builder: (context) => PublisherForm(
                updatePublisherModel: UpdatePublisherModel(
                  id: publisher.id,
                  name: publisher.name,
                  email: publisher.email,
                  description: publisher.description,
                  website: publisher.website,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Publisher not loaded yet.')),
            );
          }
        },
        child: Icon(Icons.edit),
      ),
      body: Consumer<PublisherProvider>(
        builder: (context, provider, _) {
          final isLoadingPublisher =
              provider.isLoading(PublisherOperationType.getPublisherById);
          final errorMessagePublisher =
              provider.getError(PublisherOperationType.getPublisherById);
          final publisher = provider.publisher;

          if (isLoadingPublisher) {
            // Loading State
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (errorMessagePublisher != null) {
            // Error State
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error: $errorMessagePublisher",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        provider.getPublisherById(widget.publisherId),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (publisher != null) {
            return PublisherCard(
              publisherModel: PublisherModel(
                id: publisher.id,
                name: publisher.name,
                email: publisher.email,
                description: publisher.description,
                website: publisher.website,
                createdAt: publisher.createdAt,
                updatedAt: publisher.updatedAt,
              ),
            );
          } else {
            // State kosong
            return const Center(
              child: Text("No publisher found."),
            );
          }
        },
      ),
    );
  }
}

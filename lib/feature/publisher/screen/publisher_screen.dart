import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/feature/publisher/model/publisher_model.dart';
import 'package:book_app_basic_arch/feature/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/feature/publisher/enum_publisher_operation.dart';
import 'package:book_app_basic_arch/feature/publisher/screen/publisher_detail_screen.dart';
import 'package:book_app_basic_arch/feature/publisher/widgets/publisher_card.dart';
import 'package:book_app_basic_arch/feature/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublisherScreen extends StatelessWidget {
  const PublisherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final publisherProvider =
        Provider.of<PublisherProvider>(context, listen: false);

    // Fetch publishers saat screen pertama kali diakses
    WidgetsBinding.instance.addPostFrameCallback((_) {
      publisherProvider.getPublishers();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Publishers"),
      ),
      body: RefreshIndicator(
        onRefresh: () => publisherProvider.getPublishers(),
        child: Consumer<PublisherProvider>(
          builder: (context, provider, _) {
            final isLoadingPublishers =
                provider.isLoading(EnumPublisherOperation.getAll);
            final errorMessagePublishers =
                provider.getError(EnumPublisherOperation.getAll);
            final publishers = provider.publishers;

            if (isLoadingPublishers) {
              // Loading State
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (errorMessagePublishers != null) {
              // Error State
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Error: $errorMessagePublishers",
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.getPublishers(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            if (publishers.isNotEmpty) {
              return Column(
                children: [
                  StyledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                    child: Text('To profile'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: publishers.length,
                      itemBuilder: (context, index) {
                        final publisher = publishers[index];
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
                          onTap: () {
                            // Navigasi ke halaman detail publisher
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PublisherDetailScreen(
                                  publisherId: publisher.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              // State kosong
              return const Center(
                child: Text("No publishers found."),
              );
            }
          },
        ),
      ),
    );
  }
}

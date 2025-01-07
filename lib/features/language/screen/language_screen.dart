import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/features/language/enums/language_operation_type.dart';
import 'package:book_app_basic_arch/features/language/enums/language_screen_type.dart';
import 'package:book_app_basic_arch/features/language/language_provider.dart';
import 'package:book_app_basic_arch/features/language/model/language_model.dart';
import 'package:book_app_basic_arch/features/language/screen/language_detail_screen.dart';
import 'package:book_app_basic_arch/features/language/widgets/language_card.dart';
import 'package:book_app_basic_arch/features/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    // Fetch languages saat screen pertama kali diakses
    WidgetsBinding.instance.addPostFrameCallback((_) {
      languageProvider.getLanguages();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Languages"),
      ),
      body: RefreshIndicator(
        onRefresh: () => languageProvider.getLanguages(),
        child: Consumer<LanguageProvider>(
          builder: (context, provider, _) {
            final isLoadingLanguages =
                provider.isLoading(LanguageOperationType.getLanguages);
            final errorMessageLanguages =
                provider.getError(LanguageOperationType.getLanguages);
            final languages = provider.getLanguagesForSpecificScreen(
              LanguageScreenType.languages,
            );

            if (isLoadingLanguages) {
              // Loading State
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (errorMessageLanguages != null) {
              // Error State
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Error: $errorMessageLanguages",
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.getLanguages(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            if (languages.isNotEmpty) {
              return Column(
                children: [
                  StyledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                    child: const Text('To profile'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final language = languages[index];
                        return LanguageCard(
                          languageModel: LanguageModel(
                            id: language.id,
                            name: language.name,
                            code: language.code,
                          ),
                          onTap: () {
                            // Navigasi ke halaman detail language
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LanguageDetailScreen(
                                  languageId: language.id,
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
                child: Text("No languages found."),
              );
            }
          },
        ),
      ),
    );
  }
}

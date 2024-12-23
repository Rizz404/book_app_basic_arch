import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/feature/language/model/language_model.dart';
import 'package:book_app_basic_arch/feature/language/language_provider.dart';
import 'package:book_app_basic_arch/feature/language/enum_language_operation.dart';
import 'package:book_app_basic_arch/feature/language/screen/language_detail_screen.dart';
import 'package:book_app_basic_arch/feature/language/widgets/language_card.dart';
import 'package:book_app_basic_arch/feature/profile/screen/profile_screen.dart';
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
                provider.isLoading(EnumLanguageOperation.getAll);
            final errorMessageLanguages =
                provider.getError(EnumLanguageOperation.getAll);
            final languages = provider.languages;

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
                              builder: (context) => ProfileScreen()));
                    },
                    child: Text('To profile'),
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

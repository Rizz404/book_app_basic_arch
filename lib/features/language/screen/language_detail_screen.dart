import 'package:book_app_basic_arch/features/language/enums/language_operation_type.dart';
import 'package:book_app_basic_arch/features/language/language_provider.dart';
import 'package:book_app_basic_arch/features/language/model/language_model.dart';
import 'package:book_app_basic_arch/features/language/widgets/language_card.dart';
import 'package:book_app_basic_arch/features/language/widgets/language_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageDetailScreen extends StatefulWidget {
  final String languageId;

  const LanguageDetailScreen({super.key, required this.languageId});

  @override
  State<LanguageDetailScreen> createState() => _LanguageDetailScreenState();
}

class _LanguageDetailScreenState extends State<LanguageDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LanguageProvider>().getLanguageById(widget.languageId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final languageProvider = context.read<LanguageProvider>();
          final language = languageProvider.language;

          if (language != null) {
            showDialog(
              context: context,
              builder: (context) => LanguageForm(
                updateLanguageModel: UpdateLanguageModel(
                  id: language.id,
                  name: language.name,
                  code: language.code,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Language not loaded yet.')),
            );
          }
        },
        child: const Icon(Icons.edit),
      ),
      body: Consumer<LanguageProvider>(
        builder: (context, provider, _) {
          final isLoadingLanguage =
              provider.isLoading(LanguageOperationType.getLanguageById);
          final errorMessageLanguage =
              provider.getError(LanguageOperationType.getLanguageById);
          final language = provider.language;

          if (isLoadingLanguage) {
            // Loading State
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (errorMessageLanguage != null) {
            // Error State
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error: $errorMessageLanguage",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        provider.getLanguageById(widget.languageId),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (language != null) {
            return LanguageCard(
              languageModel: LanguageModel(
                id: language.id,
                name: language.name,
                code: language.code,
              ),
            );
          } else {
            // State kosong
            return const Center(
              child: Text("No language found."),
            );
          }
        },
      ),
    );
  }
}

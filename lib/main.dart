import 'package:book_app_basic_arch/core/config/app_themes.dart';
import 'package:book_app_basic_arch/core/config/go_router.dart';
import 'package:book_app_basic_arch/core/constants/app_pallete.dart';
import 'package:book_app_basic_arch/core/shared/provider/theme_provider.dart';
import 'package:book_app_basic_arch/feature/auth/auth_provider.dart';
import 'package:book_app_basic_arch/feature/author/author_provider.dart';
import 'package:book_app_basic_arch/feature/book/book_provider.dart';
import 'package:book_app_basic_arch/feature/genre/genre_provider.dart';
import 'package:book_app_basic_arch/feature/language/language_provider.dart';
import 'package:book_app_basic_arch/feature/profile/profile_provider.dart';
import 'package:book_app_basic_arch/feature/publisher/publisher_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(AppPallete.ikuyoTheme),
      ),
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => BookProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProfileProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => GenreProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AuthorProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => PublisherProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => LanguageProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Just chilling',
      theme: AppThemes.createThemeData(themeProvider.currentTheme),
      routerConfig: goRouter,
    );
  }
}

import 'package:book_app_basic_arch/core/config/app_themes.dart';
import 'package:book_app_basic_arch/core/config/go_router.dart';
import 'package:book_app_basic_arch/core/constants/app_pallete.dart';
import 'package:book_app_basic_arch/core/shared/provider/theme_provider.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/auth/model/local/user_credential_model.dart';
import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/language/language_provider.dart';
import 'package:book_app_basic_arch/features/profile/profile_provider.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/features/wishlist/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  await Hive.initFlutter(appDocumentDirectory.path);

  // * Register semua adapter Hive di sini
  Hive.registerAdapter(UserCredentialModelAdapter());

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
        create: (_) => WishlistProvider(),
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

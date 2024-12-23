import 'package:book_app_basic_arch/core/config/go_router.dart';
import 'package:book_app_basic_arch/feature/auth/auth_provider.dart';
import 'package:book_app_basic_arch/feature/auth/screen/auth_screen.dart';
import 'package:book_app_basic_arch/feature/author/author_provider.dart';
import 'package:book_app_basic_arch/feature/author/screen/author_screen.dart';
import 'package:book_app_basic_arch/feature/book/book_provider.dart';
import 'package:book_app_basic_arch/feature/book/screen/book_screen.dart';
import 'package:book_app_basic_arch/feature/genre/genre_provider.dart';
import 'package:book_app_basic_arch/feature/genre/screen/genre_screen.dart';
import 'package:book_app_basic_arch/feature/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
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
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Just chilling',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}

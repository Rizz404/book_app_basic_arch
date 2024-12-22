import 'package:book_app_basic_arch/feature/author/author_provider.dart';
import 'package:book_app_basic_arch/feature/author/screen/author_screen.dart';
import 'package:book_app_basic_arch/feature/genre/genre_provider.dart';
import 'package:book_app_basic_arch/feature/genre/screen/genre_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Just chilling',
      home: AuthorScreen(),
    );
  }
}

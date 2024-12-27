import 'package:book_app_basic_arch/core/shared/screens/splash_screen.dart';
import 'package:book_app_basic_arch/core/shared/widgets/auth_wrapper.dart';
import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/auth/screen/login_screen.dart';
import 'package:book_app_basic_arch/features/auth/screen/register_screen.dart';
import 'package:book_app_basic_arch/features/author/screen/author_detail_screen.dart';
import 'package:book_app_basic_arch/features/author/screen/author_screen.dart';
import 'package:book_app_basic_arch/features/book/screen/book_detail_screen.dart';
import 'package:book_app_basic_arch/features/book/screen/book_screen.dart';
import 'package:book_app_basic_arch/features/genre/screen/genre_detail_screen.dart';
import 'package:book_app_basic_arch/features/genre/screen/genre_screen.dart';
import 'package:book_app_basic_arch/features/home/screen/home_screen.dart';
import 'package:book_app_basic_arch/features/language/screen/language_detail_screen.dart';
import 'package:book_app_basic_arch/features/language/screen/language_screen.dart';
import 'package:book_app_basic_arch/features/profile/screen/profile_screen.dart';
import 'package:book_app_basic_arch/features/publisher/screen/publisher_detail_screen.dart';
import 'package:book_app_basic_arch/features/publisher/screen/publisher_screen.dart';
import 'package:book_app_basic_arch/features/wishlist/screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// ! ini berdasarkan index ya, jadi urutan itu penting buat bottom navbarnya
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _navigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _navigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
final _navigatorBookKey = GlobalKey<NavigatorState>(debugLabel: 'shellBook');

// * Nanti benerin lagi
final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage(
        child: SplashScreen(),
      ),
    ),
    // * Main app routes dengan bottom navigation
    // ! bisa diakses dengan bottom nav aja
    StatefulShellRoute.indexedStack(
      builder: (context, state, statefulNavigationShell) {
        return BaseScaffold(
          statefulNavigationShell: statefulNavigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _navigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => MaterialPage(
                child: HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorBookKey,
          routes: [
            GoRoute(
              path: '/wishlist',
              pageBuilder: (context, state) => MaterialPage(
                child: WishlistScreen(),
              ),
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorProfileKey,
          routes: [
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => MaterialPage(
                child: AuthWrapper(
                  child: ProfileScreen(),
                ),
              ),
            )
          ],
        ),
      ],
    ),

    // * Routes di luar bottom navigation
    GoRoute(
      path: '/sign-up',
      pageBuilder: (context, state) => MaterialPage(
        child: RegisterScreen(),
      ),
    ),
    GoRoute(
      path: '/sign-in',
      pageBuilder: (context, state) => MaterialPage(
        child: LoginScreen(),
      ),
    ),

    GoRoute(
      path: '/books',
      pageBuilder: (context, state) => MaterialPage(
        child: BookScreen(),
      ),
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final bookId = state.pathParameters['id']!;
            return MaterialPage(
              child: BookDetailScreen(bookId: bookId),
            );
          },
        ),
      ],
    ),

    GoRoute(
      path: '/genres',
      pageBuilder: (context, state) => MaterialPage(
        child: GenreScreen(),
      ),
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final genreId = state.pathParameters['id']!;
            return MaterialPage(
              child: GenreDetailScreen(genreId: genreId),
            );
          },
        ),
      ],
    ),

    GoRoute(
      path: '/authors',
      pageBuilder: (context, state) => MaterialPage(
        child: AuthorScreen(),
      ),
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final authorId = state.pathParameters['id']!;
            return MaterialPage(
              child: AuthorDetailScreen(authorId: authorId),
            );
          },
        ),
      ],
    ),

    GoRoute(
      path: '/publishers',
      pageBuilder: (context, state) => MaterialPage(
        child: PublisherScreen(),
      ),
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final publisherId = state.pathParameters['id']!;
            return MaterialPage(
              child: PublisherDetailScreen(publisherId: publisherId),
            );
          },
        ),
      ],
    ),

    GoRoute(
      path: '/languages',
      pageBuilder: (context, state) => MaterialPage(
        child: LanguageScreen(),
      ),
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final languageId = state.pathParameters['id']!;
            return MaterialPage(
              child: LanguageDetailScreen(languageId: languageId),
            );
          },
        ),
      ],
    ),
  ],

  // * Redirect logic
  redirect: (context, state) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isAuthenticated = authProvider.isAuthenticated;
    final authRoutes = ['/sign-up', '/sign-up'];

    if (isAuthenticated && authRoutes.contains(state.fullPath)) {
      return '/home';
    }

    return null;
  },
);

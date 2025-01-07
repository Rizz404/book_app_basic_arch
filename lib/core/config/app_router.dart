import 'package:book_app_basic_arch/core/shared/screens/error_screen.dart';
import 'package:book_app_basic_arch/core/shared/screens/menu_screen.dart';
import 'package:book_app_basic_arch/core/shared/screens/splash_screen.dart';
import 'package:book_app_basic_arch/core/shared/widgets/auth_wrapper.dart';
import 'package:book_app_basic_arch/core/shared/widgets/scaffold_with_bottom_app_bar.dart';
import 'package:book_app_basic_arch/features/admin/screen/author_upsert_screen.dart';
import 'package:book_app_basic_arch/features/admin/screen/book_upsert_screen.dart';
import 'package:book_app_basic_arch/features/admin/screen/genre_upsert_screen.dart';
import 'package:book_app_basic_arch/features/admin/screen/publisher_upsert_screen.dart';
import 'package:book_app_basic_arch/features/auth/screen/login_screen.dart';
import 'package:book_app_basic_arch/features/auth/screen/register_screen.dart';
import 'package:book_app_basic_arch/features/author/screen/author_detail_screen.dart';
import 'package:book_app_basic_arch/features/author/screen/author_screen.dart';
import 'package:book_app_basic_arch/features/author/screen/author_search_result_screen.dart';
import 'package:book_app_basic_arch/features/book/screen/book_detail_screen.dart';
import 'package:book_app_basic_arch/features/book/screen/book_screen.dart';
import 'package:book_app_basic_arch/features/book/screen/book_search_result_screen.dart';
import 'package:book_app_basic_arch/features/genre/screen/genre_detail_screen.dart';
import 'package:book_app_basic_arch/features/genre/screen/genre_screen.dart';
import 'package:book_app_basic_arch/features/genre/screen/genre_search_result_screen.dart';
import 'package:book_app_basic_arch/features/home/screen/home_screen.dart';
import 'package:book_app_basic_arch/features/profile/screen/profile_screen.dart';
import 'package:book_app_basic_arch/features/profile/screen/profile_update_screen.dart';
import 'package:book_app_basic_arch/features/publisher/screen/publisher_detail_screen.dart';
import 'package:book_app_basic_arch/features/publisher/screen/publisher_screen.dart';
import 'package:book_app_basic_arch/features/publisher/screen/publisher_search_result_screen.dart';
import 'package:book_app_basic_arch/features/search/screen/search_screen.dart';
import 'package:book_app_basic_arch/features/wishlist/screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _navigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _navigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final _navigatorBookKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellBook');

  static final goRouter = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/menu',
        pageBuilder: (context, state) => const MaterialPage(
          child: MenuScreen(),
        ),
      ),

      // * Main app routes dengan bottom navigation
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, statefulNavigationShell) {
          return ScaffoldWithBottomAppBar(
            statefulNavigationShell: statefulNavigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _navigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) => const MaterialPage(
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
                pageBuilder: (context, state) => const MaterialPage(
                  child: AuthWrapper(child: WishlistScreen()),
                ),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _navigatorProfileKey,
            routes: [
              GoRoute(
                  path: '/profile',
                  pageBuilder: (context, state) => const MaterialPage(
                        child: AuthWrapper(child: ProfileScreen()),
                      ),
                  routes: [
                    GoRoute(
                      path: 'update',
                      pageBuilder: (context, state) => const MaterialPage(
                        child: ProfileUpdateScreen(),
                      ),
                    ),
                  ])
            ],
          ),
        ],
      ),

      // * Routes di luar bottom navigation
      GoRoute(
        path: '/sign-up',
        pageBuilder: (context, state) => const MaterialPage(
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        path: '/sign-in',
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginScreen(),
        ),
      ),

      GoRoute(
        path: '/search',
        pageBuilder: (context, state) => const MaterialPage(
          child: SearchScreen(),
        ),
      ),

      GoRoute(
        path: '/books',
        pageBuilder: (context, state) => const MaterialPage(
          child: BookScreen(),
        ),
        routes: [
          GoRoute(
            path: 'search',
            builder: (context, state) {
              final query = state.uri.queryParameters['q'] ?? '';
              return BookSearchResultScreen(query: query);
            },
          ),
          GoRoute(
            path: 'upsert',
            pageBuilder: (context, state) {
              final bookId = state.pathParameters['id'];
              return MaterialPage(
                child: BookUpsertScreen(bookId: bookId),
              );
            },
          ),
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
        pageBuilder: (context, state) => const MaterialPage(
          child: GenreScreen(),
        ),
        routes: [
          GoRoute(
            path: 'search',
            builder: (context, state) {
              final query = state.uri.queryParameters['q'] ?? '';
              return GenreSearchResultScreen(query: query);
            },
          ),
          GoRoute(
            path: 'create',
            pageBuilder: (context, state) => const MaterialPage(
              child: GenreUpsertScreen(),
            ),
          ),
          // Route untuk update
          GoRoute(
            path: 'edit/:id',
            pageBuilder: (context, state) {
              final genreId = state.pathParameters['id'];
              return MaterialPage(
                child: GenreUpsertScreen(genreId: genreId),
              );
            },
          ),
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
        pageBuilder: (context, state) => const MaterialPage(
          child: AuthorScreen(),
        ),
        routes: [
          GoRoute(
            path: 'search',
            builder: (context, state) {
              final query = state.uri.queryParameters['q'] ?? '';
              return AuthorSearchResultScreen(query: query);
            },
          ),
          GoRoute(
            path: 'upsert',
            pageBuilder: (context, state) {
              final authorId = state.pathParameters['id'];
              return MaterialPage(
                child: AuthorUpsertScreen(authorId: authorId),
              );
            },
          ),
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
        pageBuilder: (context, state) => const MaterialPage(
          child: PublisherScreen(),
        ),
        routes: [
          GoRoute(
            path: 'search',
            builder: (context, state) {
              final query = state.uri.queryParameters['q'] ?? '';
              return PublisherSearchResultScreen(query: query);
            },
          ),
          GoRoute(
            path: 'upsert',
            pageBuilder: (context, state) {
              final publisherId = state.pathParameters['id'];
              return MaterialPage(
                child: PublisherUpsertScreen(publisherId: publisherId),
              );
            },
          ),
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
    ],

    // * Redirect logic
    // redirect: (context, state) {
    //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
    //   final isAuthenticated = authProvider.isAuthenticated;

    //   // * Cek apakah sedang di splash screen
    //   final isSplash = state.uri.toString() == '/';
    //   if (isSplash) return null;

    //   // * Daftar route autentikasi
    //   final authRoutes = ['/sign-in', '/sign-up'];

    //   // * Cek apakah sedang di halaman auth
    //   final isAuthRoute = authRoutes.contains(state.uri.toString());

    //   if (isAuthenticated && isAuthRoute) {
    //     // * Cek apakah ada redirect location setelah login
    //     final fromLocation = state.uri.queryParameters['from'];
    //     return fromLocation ?? '/home';
    //   }

    //   // * Tidak perlu redirect
    //   return null;
    // },
    errorBuilder: (context, state) => const ErrorScreen(),
  );
}

import 'package:book_app_basic_arch/core/shared/widgets/auth_wrapper.dart';
import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/feature/auth/auth_provider.dart';
import 'package:book_app_basic_arch/feature/auth/screen/auth_screen.dart';
import 'package:book_app_basic_arch/feature/author/screen/author_detail_screen.dart';
import 'package:book_app_basic_arch/feature/author/screen/author_screen.dart';
import 'package:book_app_basic_arch/feature/book/screen/book_detail_screen.dart';
import 'package:book_app_basic_arch/feature/book/screen/book_screen.dart';
import 'package:book_app_basic_arch/feature/genre/screen/genre_detail_screen.dart';
import 'package:book_app_basic_arch/feature/genre/screen/genre_screen.dart';
import 'package:book_app_basic_arch/feature/home/screen/home_screen.dart';
import 'package:book_app_basic_arch/feature/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// ! ini berdasarkan index ya, jadi urutan itu penting buat bottom navbarnya
// todo: Nanti ganti pake identifier
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _navigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _navigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
final _navigatorBookKey = GlobalKey<NavigatorState>(debugLabel: 'shellBook');
final _navigatorGenreKey = GlobalKey<NavigatorState>(debugLabel: 'shellGenre');
final _navigatorAuthorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAuthor');

final goRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // * Auth routes (di luar shell navigation)
    GoRoute(
      path: '/auth',
      builder: (context, state) => AuthScreen(),
    ),

    // * Main app routes dengan bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, statefulNavigationShell) {
        // * Semua routes dalam shell membutuhkan auth
        return BaseScaffold(
          statefulNavigationShell: statefulNavigationShell,
        );
      },
      branches: [
        // * Home branch
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

        // * Books branch
        StatefulShellBranch(
          navigatorKey: _navigatorBookKey,
          routes: [
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
                ])
          ],
        ),

        // * Profile branch
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

        // * Genres branch
        StatefulShellBranch(
          navigatorKey: _navigatorGenreKey,
          routes: [
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
          ],
        ),

        // * Authors branch
        StatefulShellBranch(
          navigatorKey: _navigatorAuthorKey,
          routes: [
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
          ],
        ),
      ],
    )
  ],

  // * Redirect logic
  redirect: (context, state) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isAuthenticated = authProvider.isAuthenticated;
    final isAuthRoute = state.fullPath == '/auth';

    // // * Jika belum auth dan bukan di route auth, redirect ke auth
    // if (!isAuthenticated && !isAuthRoute) {
    //   return '/auth';
    // }

    // * Jika sudah auth dan di route auth, redirect ke home
    if (isAuthenticated && isAuthRoute) {
      return '/home';
    }

    return null;
  },
);

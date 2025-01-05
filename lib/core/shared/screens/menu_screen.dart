import 'package:book_app_basic_arch/core/helpers/user_credential_manager.dart';
import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserCredentialManager userCredentialManager = UserCredentialManager();

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(
          title: Text("Menu"),
        ),
        builder: (builder, controller) {
          return [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        StyledUserAvatar(),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userCredentialManager.credentials?.username ??
                                  "user",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              userCredentialManager.credentials?.email ??
                                  "user",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => context.go('/profile'),
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Menu",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text("Books"),
                    onTap: () => context.pushReplacement('/books'),
                  ),
                  ListTile(
                    leading: Icon(Icons.category),
                    title: Text("Genres"),
                    onTap: () => context.pushReplacement('/genres'),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Authors"),
                    onTap: () => context.pushReplacement('/authors'),
                  ),
                  ListTile(
                    leading: Icon(Icons.publish),
                    title: Text("Publishers"),
                    onTap: () => context.pushReplacement('/publishers'),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }
}

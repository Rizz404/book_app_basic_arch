import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(title: Text('Profile')),
        builder: (builder, controller) {
          return [
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // * Pakenya itu background image kalo circle avatar
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          authProvider.userCredential?.profilePicture ??
                              'kintil',
                        ),
                      ),
                      SizedBox(height: 16),

                      Column(
                        children: [
                          Text(
                            authProvider.userCredential?.username ?? 'kintil',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            authProvider.userCredential?.email ?? 'kintil',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: StyledButton(
                              onPressed: () {
                                context.push('/profile/update');
                              },
                              child: Text('Update'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: StyledButton(
                              onPressed: () {
                                authProvider.signOut();
                              },
                              child: Text('Logout'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ];
        });
  }
}

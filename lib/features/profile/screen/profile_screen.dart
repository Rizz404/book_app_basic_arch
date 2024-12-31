import 'package:book_app_basic_arch/core/helpers/current_user_credential_manager.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrentUserCredentialManager currentUser =
        CurrentUserCredentialManager();

    return StyledScreenLayoutBuilder(builder: (builder, controller) {
      return [
        SliverToBoxAdapter(
          child: Column(
            children: [
              // * Pakenya itu background image kalo circle avatar
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  currentUser.profilePicture ?? 'kintil',
                ),
              ),
              SizedBox(height: 16),

              Column(
                children: [
                  Text(
                    currentUser.username ?? 'kintil',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    currentUser.email ?? 'kintil',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                      onPressed: () {},
                      child: Text('Update'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: StyledButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .signOut();
                      },
                      child: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ];
    });
  }
}

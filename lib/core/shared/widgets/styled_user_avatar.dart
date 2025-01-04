import 'package:book_app_basic_arch/core/helpers/user_credential_manager.dart';
import 'package:flutter/material.dart';

class StyledUserAvatar extends StatelessWidget {
  StyledUserAvatar({super.key});

  final UserCredentialManager userCredential = UserCredentialManager();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundImage: NetworkImage(
        userCredential.credentials?.profilePicture ??
            "https://i.pinimg.com/236x/0e/f3/6f/0ef36fb12fec6342b5f0116cf613c0ab.jpg",
      ),
    );
  }
}

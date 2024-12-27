import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_field.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/auth/enum_auth_operation.dart';
import 'package:book_app_basic_arch/features/auth/model/auth_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignUp = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // * Fungsi untuk reset nilai dan fokus
  void _resetFields() {
    FocusScope.of(context).unfocus(); // * Reset fokus
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (BuildContext context, provider, _) {
          final isLoadingRegister =
              provider.isLoading(EnumAuthOperation.signUp);
          final isLoadingSignInModel =
              provider.isLoading(EnumAuthOperation.signIn);
          final errorMessageSignUp =
              provider.getError(EnumAuthOperation.signUp);
          final errorMessageSignIn =
              provider.getError(EnumAuthOperation.signIn);

          if (isLoadingRegister || isLoadingSignInModel) {
            // Loading State
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (errorMessageSignUp != null || errorMessageSignIn != null) {
            // Error State
            return Center(
              child: Text(
                "${_isSignUp ? errorMessageSignUp : errorMessageSignIn}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isSignUp ? 'Sign Up' : 'Sign In',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                // ? baru tau ada spread di dart
                ..._buildFields(),
                const SizedBox(height: 24),
                StyledButton(
                  onPressed: () async {
                    if (_isSignUp) {
                      provider.signUp(SignUpModel(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                      ));
                    } else {
                      // * Tunggu proses sign-in selesai
                      await provider.signIn(SignInModel(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ));

                      // * Periksa apakah berhasil login
                      if (errorMessageSignIn == null && mounted) {
                        context.go('/home');
                      }
                    }
                  },
                  child: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    text: _isSignUp
                        ? 'Already have an account? '
                        : 'Don\'t have an account? ',
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: _isSignUp ? 'Sign In' : 'Sign Up',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              _isSignUp = !_isSignUp;
                              _resetFields();
                            });
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildFields() {
    List<Widget> fields = [
      StyledTextField(
        hintText: 'Email',
        controller: _emailController,
      ),
      const SizedBox(height: 16),
      StyledTextField(
        hintText: 'Password',
        controller: _passwordController,
        isPassword: true,
      ),
    ];

    if (_isSignUp) {
      fields.addAll([
        const SizedBox(height: 16),
        StyledTextField(
          hintText: 'Username',
          controller: _usernameController,
        ),
        const SizedBox(height: 16),
        StyledTextField(
          hintText: 'Confirm Password',
          controller: _confirmPasswordController,
          isPassword: true,
        ),
      ]);
    }

    return fields;
  }
}

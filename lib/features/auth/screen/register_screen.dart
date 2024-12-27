import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_form_field.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/auth/enum_auth_operation.dart';
import 'package:book_app_basic_arch/features/auth/model/auth_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
          final isLoadingSignUpModel =
              provider.isLoading(EnumAuthOperation.signUp);
          final errorMessageSigUp = provider.getError(EnumAuthOperation.signUp);

          if (isLoadingSignUpModel) {
            // Loading State
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (errorMessageSigUp != null) {
            // Error State
            return Center(
              child: Text(
                errorMessageSigUp,
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/splash-screen-logo.png",
                    width: 200,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Sign Up',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 48),
                  StyledTextFormField(
                    hintText: 'Username',
                    label: Text('Username'),
                    controller: _usernameController,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    leadingIcon: Icon(
                      Icons.account_box,
                    ),
                  ),
                  const SizedBox(height: 16),
                  StyledTextFormField(
                    hintText: 'Email',
                    label: Text('Email'),
                    controller: _emailController,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    leadingIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                  const SizedBox(height: 16),
                  StyledTextFormField(
                    hintText: 'Password',
                    label: Text('Password'),
                    controller: _passwordController,
                    isPassword: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    leadingIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                  const SizedBox(height: 16),
                  StyledTextFormField(
                    hintText: 'Confirm Password',
                    label: Text('Confirm Password'),
                    controller: _confirmPasswordController,
                    isPassword: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    leadingIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push('/sign-in');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: StyledButton(
                      onPressed: () async {
                        // * Tunggu proses sign-in selesai
                        await provider.signUp(SignUpModel(
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text,
                        ));

                        // * Periksa apakah berhasil login
                        if (errorMessageSigUp == null && context.mounted) {
                          context.push('/');
                        }
                      },
                      child: Text('Sign Up'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

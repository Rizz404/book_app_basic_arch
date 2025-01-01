import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_form_field.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/auth/enum_auth_operation.dart';
import 'package:book_app_basic_arch/features/auth/model/remote/auth_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLoginSuccess() {
    // * Ambil parameter 'from' dari URL
    final fromLocation = GoRouterState.of(context).uri.queryParameters['from'];

    if (fromLocation != null) {
      context.go(fromLocation);
    } else {
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (BuildContext context, provider, _) {
          final isLoadingSignInModel =
              provider.isLoading(EnumAuthOperation.signIn);
          final errorMessageSignIn =
              provider.getError(EnumAuthOperation.signIn);

          if (isLoadingSignInModel) {
            // Loading State
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (errorMessageSignIn != null) {
            // Error State
            return Center(
              child: Text(
                errorMessageSignIn,
                style: const TextStyle(color: Colors.red),
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
                    'Sign In',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 48),
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
                  Container(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push('/sign-up');
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
                        await provider.signIn(SignInModel(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ));

                        // * Periksa apakah berhasil login
                        if (errorMessageSignIn == null && context.mounted) {
                          _handleLoginSuccess();
                        }
                      },
                      child: Text('Sign In'),
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

import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_form_field.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/auth/enum_auth_operation.dart';
import 'package:book_app_basic_arch/features/auth/model/remote/auth_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// todo: Belum bener
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

  bool _showEmailVerificationMessage = false;

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
          final errorMessageSignUp =
              provider.getError(EnumAuthOperation.signUp);

          if (isLoadingSignUpModel) {
            // Loading State
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (errorMessageSignUp != null) {
            // Error State
            return Center(
              child: Text(
                errorMessageSignUp,
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // * Bakal invisible
                    Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/splash-screen-logo.png",
                            width: 200,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
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

                    if (_showEmailVerificationMessage) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Silakan periksa email Anda untuk verifikasi akun sebelum melakukan login.',
                          style: TextStyle(color: Colors.blue.shade700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],

                    if (errorMessageSignUp != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          errorMessageSignUp,
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],

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

                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: StyledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Password tidak cocok'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            try {
                              await provider.signUp(SignUpModel(
                                username: _usernameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              ));

                              if (mounted) {
                                setState(() {
                                  _showEmailVerificationMessage = true;
                                });

                                // * Clear form
                                _usernameController.clear();
                                _emailController.clear();
                                _passwordController.clear();
                                _confirmPasswordController.clear();
                              }
                            } catch (e) {
                              // Error akan ditangani oleh provider
                            }
                          }
                        },
                        child: Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

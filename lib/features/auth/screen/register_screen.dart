import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_form_field.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/auth/enums/auth_operation_type.dart';
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

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _showEmailVerificationMessage = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updateFadeAnimation(bool isKeyboardVisible) {
    if (isKeyboardVisible) {
      _fadeController.reverse();
    } else {
      _fadeController.forward();
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Username minimal 3 karakter';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 5) {
      return 'Password minimal 5 karakter';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (value != _passwordController.text) {
      return 'Password tidak cocok';
    }
    return null;
  }

// Fokus pada bagian _handleSubmit, sisanya tetap sama
  Future<void> _handleSubmit(AuthProvider provider) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await provider.signUp(SignUpModel(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ));

        if (mounted) {
          // Hanya clear form dan tampilkan pesan verifikasi jika signup berhasil
          if (provider.getError(AuthOperationType.signUp) == null) {
            setState(() {
              _showEmailVerificationMessage = true;
            });

            // Clear form
            _usernameController.clear();
            _emailController.clear();
            _passwordController.clear();
            _confirmPasswordController.clear();
          }
        }
      } catch (e) {
        // Error sudah ditangani oleh provider, tidak perlu melakukan apa-apa di sini
        // karena provider akan mengupdate error state yang akan ditampilkan di UI
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenHeight = MediaQuery.of(context).size.height;

    _updateFadeAnimation(isKeyboardVisible);

    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (BuildContext context, provider, _) {
          final isLoadingSignUp = provider.isLoading(AuthOperationType.signUp);
          final errorMessageSignUp =
              provider.getError(AuthOperationType.signUp);

          if (isLoadingSignUp) {
            return const Center(
              child: StyledLoadingState(),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        screenHeight - MediaQuery.of(context).padding.top,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // * Verif dulu
                            if (_showEmailVerificationMessage)
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 24),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  border: Border.all(
                                    color: Colors.blue.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Silakan periksa email Anda untuk verifikasi akun sebelum melakukan login.',
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                            if (errorMessageSignUp != null)
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 24),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  border: Border.all(
                                    color: Colors.red.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  errorMessageSignUp,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: Image.asset(
                                "assets/images/splash-screen-logo.png",
                                width: 200,
                              ),
                            ),
                            const SizedBox(height: 24),

                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 48),

                            StyledTextFormField(
                              hintText: 'Username',
                              label: const Text('Username'),
                              controller: _usernameController,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              leadingIcon: const Icon(
                                Icons.account_box,
                              ),
                              validator: _validateUsername,
                            ),
                            const SizedBox(height: 16),

                            StyledTextFormField(
                              hintText: 'Email',
                              label: const Text('Email'),
                              controller: _emailController,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              leadingIcon: const Icon(
                                Icons.email_outlined,
                              ),
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 16),

                            StyledTextFormField(
                              hintText: 'Password',
                              label: const Text('Password'),
                              controller: _passwordController,
                              isPassword: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              leadingIcon: const Icon(
                                Icons.lock,
                              ),
                              validator: _validatePassword,
                            ),
                            const SizedBox(height: 16),

                            StyledTextFormField(
                              hintText: 'Confirm Password',
                              label: const Text('Confirm Password'),
                              controller: _confirmPasswordController,
                              isPassword: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              leadingIcon: const Icon(
                                Icons.lock,
                              ),
                              validator: _validateConfirmPassword,
                            ),
                            const SizedBox(height: 24),

                            Container(
                              alignment: Alignment.centerRight,
                              child: RichText(
                                textAlign: TextAlign.end,
                                text: TextSpan(
                                  text: 'Sudah punya akun? ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Sign In',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontSize: 16,
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
                            const SizedBox(height: 16),

                            SizedBox(
                              width: double.infinity,
                              child: StyledButton(
                                onPressed: () => !isLoadingSignUp
                                    ? _handleSubmit(provider)
                                    : null,
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

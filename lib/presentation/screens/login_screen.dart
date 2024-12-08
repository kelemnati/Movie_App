import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/authentication/authentication_bloc.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/presentation/widgets/input_field_widget.dart';
import 'package:movie_app/route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Title Section
            const SizedBox(height: 70),
            Text(
              "Login here",
              style: typography.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              "Welcome back, you've been missed!",
              style: typography.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Form Section
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InputFieldWidget(
                    label: "Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        value!.contains('@') ? null : "Enter a valid email",
                  ),
                  const SizedBox(height: 16),
                  InputFieldWidget(
                    label: "Password",
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) => value!.length >= 6
                        ? null
                        : "Password must be at least 6 characters long",
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Forgot Password Action
                  Navigator.pushNamed(context, '/forgot_password');
                },
                child: Text(
                  "Forgot your password?",
                  style: typography.labelMedium.copyWith(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Login Button
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is AuthSuccess) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              builder: (context, state) {
                final isLoading = state is AuthLoading;

                return SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthenticationBloc>().add(
                                    SignInRequested(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text("Sign In", style: typography.labelLarge),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Create New Account Link
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.signUp);
              },
              child: Text(
                "Create new account",
                style: typography.labelMedium.copyWith(),
              ),
            ),

            // Social Media Login Section
            const SizedBox(height: 24),
            Text(
              "Or continue with",
              style: typography.displayMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialMediaIcon(theme, "assets/images/google.png"),
                const SizedBox(width: 16),
                _socialMediaIcon(theme, "assets/images/facebook.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialMediaIcon(AppTheme theme, String assetPath) {
    return InkWell(
      onTap: () {
        // Social Media Login Action
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          assetPath,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}

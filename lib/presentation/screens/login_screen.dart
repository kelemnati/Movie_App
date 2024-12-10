import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/authentication/authentication_bloc.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/presentation/widgets/common_widgets.dart';
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
            const VerticalSpacer(height: 70),
            Text(
              "Login here",
              style: typography.headlineMedium,
            ),
            const VerticalSpacer(height: 8),
            Text(
              "Welcome back, you've been missed!",
              style: typography.displayMedium,
              textAlign: TextAlign.center,
            ),
            const VerticalSpacer(height: 32),

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
                  const VerticalSpacer(height: 16),
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
            const VerticalSpacer(height: 8),
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
            const VerticalSpacer(height: 16),

            // Login Button
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is AuthSuccess) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
              },
              builder: (context, state) {
                final isLoading = state is AuthLoading;

                return AuthButton(
                    text: "Sign In",
                    isLoading: isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthenticationBloc>().add(
                              SignInRequested(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    });
              },
            ),
            const VerticalSpacer(height: 16),

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
            const VerticalSpacer(height: 24),
            Text(
              "Or continue with",
              style: typography.displayMedium,
            ),
            const VerticalSpacer(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaIcon(
                    assetPath: "assets/images/google.png", theme: theme),
                const HorizontalSpacer(width: 16),
                SocialMediaIcon(
                    assetPath: "assets/images/facebook.png", theme: theme),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

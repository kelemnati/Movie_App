import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/authentication/authentication_bloc.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/presentation/widgets/common_widgets.dart';
import 'package:movie_app/route.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Create Account",
                  style: typography.headlineMedium,
                ),
                const VerticalSpacer(height: 15),
                Text(
                  "Create an account so you can explore all the existing movies.",
                  style: typography.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            // Form Fields
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Username Field
                  InputFieldWidget(
                    label: "Username",
                    controller: _userNameController,
                    validator: (value) =>
                        value!.isNotEmpty ? null : "Username is required",
                    textInputAction: TextInputAction.next,
                  ),
                  const VerticalSpacer(height: 20),
                  // Email Field
                  InputFieldWidget(
                    label: "Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.contains('@') ? null : "Enter a valid email",
                    textInputAction: TextInputAction.next,
                  ),
                  const VerticalSpacer(height: 20),
                  InputFieldWidget(
                    label: "Password",
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) => value!.length >= 6
                        ? null
                        : "Password must be at least 6 characters long",
                    textInputAction: TextInputAction.next,
                  ),
                  const VerticalSpacer(height: 20),
                  // Confirm Password Field
                  InputFieldWidget(
                    label: "Confirm Password",
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (value) => value == _passwordController.text
                        ? null
                        : "Passwords do not match",
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),

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
                  text: "Sign Up",
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthenticationBloc>().add(
                            SignUpRequested(
                              email: _emailController.text,
                              userName: _userNameController.text,
                              password: _passwordController.text,
                            ),
                          );
                    }
                  },
                );
              },
            ),

            // Login Text
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              // style: theme.,
              child: Text(
                "Already have an account? Log in",
                style: typography.labelMedium,
              ),
            ),
            Text(
              "Or continue with",
              style: typography.displayMedium,
            ),
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

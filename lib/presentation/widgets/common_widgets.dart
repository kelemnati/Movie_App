import 'package:flutter/material.dart';
import 'package:movie_app/config/themes/app_theme.dart';

/// Vertical Spacer Widget
class VerticalSpacer extends StatelessWidget {
  final double height;

  const VerticalSpacer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

//horizontal Spacer Widget
class HorizontalSpacer extends StatelessWidget {
  final double width;

  const HorizontalSpacer({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

/// Social Media Icon Widget
class SocialMediaIcon extends StatelessWidget {
  final AppTheme theme;
  final String assetPath;
  final VoidCallback? onTap;

  const SocialMediaIcon({
    Key? key,
    required this.theme,
    required this.assetPath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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

/// Authentication Button (Sign Up & Login)
class AuthButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Function onPressed;

  const AuthButton({
    Key? key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : () => onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(text, style: typography.labelLarge),
      ),
    );
  }
}

/// Input Field Widget
class InputFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;

  const InputFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: TextStyle(
        color: theme.primaryText,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: theme.secondaryText,
          fontSize: 17,
          fontWeight: FontWeight.normal,
        ),
        filled: true,
        fillColor: theme.inputFieldBackground,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.inputFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.error),
        ),
      ),
      validator: validator,
    );
  }
}

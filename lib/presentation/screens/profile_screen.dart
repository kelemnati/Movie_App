import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/authentication/authentication_bloc.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/presentation/widgets/common_widgets.dart';
import 'package:movie_app/route.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.select<AuthenticationBloc, String?>(
      (bloc) {
        if (bloc.state is AuthSuccess) {
          final name = (bloc.state as AuthSuccess).userName;
          return name.isNotEmpty
              ? '${name[0].toUpperCase()}${name.substring(1)}'
              : "User";
        }
        return "User";
      },
    );
    final userEmail = context.select<AuthenticationBloc, String?>((bloc) {
      if (bloc.state is AuthSuccess) {
        final email = (bloc.state as AuthSuccess).email;
        return email;
      }
      return "Unknown Email";
    });
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Picture
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: theme.secondaryBackground,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: theme.primaryText,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: theme.primary,
                    radius: 16,
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpacer(height: 10),
            // User Information
            Text(
              "$userName",
              style: typography.headlineLarge,
            ),
            const SizedBox(height: 5),
            Text(
              "$userEmail",
              style:
                  typography.bodyMediumWhite.copyWith(color: theme.primaryText),
            ),
            const VerticalSpacer(height: 15),
            // Edit Profile Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: theme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Edit Profile",
                style: typography.labelMedium,
              ),
            ),
            const VerticalSpacer(height: 20),
            // Divider
            Divider(color: theme.lineColor, thickness: 1),
            const VerticalSpacer(height: 10),
            // Settings Options
            ListTile(
              leading: Icon(Icons.settings, color: theme.primary),
              title: Text("Settings", style: typography.titleSmall),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.group, color: theme.primary),
              title: Text("User Management", style: typography.titleSmall),
              onTap: () {},
            ),
            Divider(color: theme.lineColor, thickness: 1),
            const VerticalSpacer(height: 10),
            ListTile(
              leading: Icon(Icons.info, color: theme.primary),
              title: Text("Terms and Conditions", style: typography.titleSmall),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout, color: theme.error),
              title: Text(
                "Log Out",
                style: typography.titleSmall.copyWith(color: theme.error),
              ),
              onTap: () {
                context.read<AuthenticationBloc>().add(SignOutRequested());
                Navigator.pushNamed(context, AppRoutes.signUp);
              },
            ),
          ],
        ),
      ),
    );
  }
}

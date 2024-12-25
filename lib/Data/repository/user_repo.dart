import 'dart:async';

import 'package:movie_app/Data/data_provider/user_data_provider.dart';
import 'package:movie_app/Data/model/user_model.dart';

class UserRepository {
  final UserDataProvider userDataProvider;

  UserRepository({required this.userDataProvider});

  Future<UserModel> signUp(
      String email, String password, String userName) async {
    try {
      return await userDataProvider.signUp(email, password, userName);
    } catch (e) {
      throw Exception("Failed to sign up: $e");
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      return await userDataProvider.signIn(email, password);
    } catch (e) {
      throw Exception("Failed to sign in: $e");
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      return await userDataProvider.getCurrentUser();
    } catch (e) {
      throw Exception("Failed to get current user: $e");
    }
  }

  Future<void> addLikedMovie(String movieId) async {
    try {
      await userDataProvider.addLikedMovie(movieId);
    } catch (e) {
      throw Exception("Failed to add liked movie: $e");
    }
  }

  Future<void> removeLikedMovie(String movieId) async {
    try {
      await userDataProvider.removeLikedMovie(
          movieId); // Assuming this method exists in your UserDataProvider
    } catch (e) {
      throw Exception("Failed to remove liked movie: $e");
    }
  }

  Future<List<String>> fetchLikedMovies() async {
    try {
      return await userDataProvider.getLikedMovies();
    } catch (e) {
      throw Exception("Failed to fetch liked movies: $e");
    }
  }

  Future<void> signOut() async {
    try {} catch (e) {
      throw Exception(e);
    }
  }
}

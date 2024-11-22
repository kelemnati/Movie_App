import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/Data/model/user_model.dart';

class UserDataProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> signUp(
      String email, String password, String userName) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(userName);
        return UserModel(
          id: user.uid,
          email: user.email!,
          userName: userName,
          likedMovies: [],
        );
      } else {
        throw Exception("Failed to create user");
      }
    } catch (e) {
      throw Exception("Error signing up: $e");
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        return UserModel(
            id: user.uid,
            email: user.email!,
            userName: user.displayName ?? 'No Name',
            likedMovies: []);
      } else {
        throw Exception("Failed to sign in");
      }
    } catch (e) {
      throw Exception("Error signing in: $e");
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final User? user = _auth.currentUser;

      if (user != null) {
        return UserModel(
          id: user.uid,
          email: user.email!,
          userName: user.displayName ?? 'No Name',
          likedMovies: [],
        );
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error fetching current user: $e");
    }
  }

  Future<void> addLikedMovie(String movieId) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("No user is signed in");
      }

      final userDoc = _firestore.collection('users').doc(user.uid);

      await userDoc.update({
        'likedMovies': FieldValue.arrayUnion([movieId]),
      });
    } catch (e) {
      throw Exception("Failed to add liked movie: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Error signing out: $e");
    }
  }
}

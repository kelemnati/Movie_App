import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/Data/model/user_model.dart';

class UserDataProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _ensureUserDocumentExists(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    if (!(await userDoc.get()).exists) {
      await userDoc.set({
        'email': user.email,
        'userName': user.displayName ?? 'No Name',
        'likedMovies': [],
      });
    }
  }

  Future<UserModel> signUp(
      String email, String password, String userName) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(userName);

        // Create Firestore document in 'users' collection
        final userDoc = _firestore.collection('users').doc(user.uid);
        await userDoc.set({
          'email': user.email,
          'userName': userName,
          'likedMovies': [],
        });

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
        // Ensure the user's Firestore document exists
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (!userDoc.exists) {
          // Create the Firestore document if it doesn't exist
          await _firestore.collection('users').doc(user.uid).set({
            'email': user.email,
            'userName': user.displayName ?? 'No Name',
            'likedMovies': [],
          });
        }

        return UserModel(
          id: user.uid,
          email: user.email!,
          userName: user.displayName ?? 'No Name',
          likedMovies: await getLikedMovies(),
        );
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
        await _ensureUserDocumentExists(user);
        return UserModel(
          id: user.uid,
          email: user.email!,
          userName: user.displayName ?? 'No Name',
          likedMovies: await getLikedMovies(),
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
      print("Movie added to favorites: $movieId");
    } catch (e) {
      throw Exception("Failed to add liked movie: $e");
    }
  }

  Future<void> removeLikedMovie(String movieId) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("No user is signed in");
      }

      final userDoc = _firestore.collection('users').doc(user.uid);

      await userDoc.update({
        'likedMovies': FieldValue.arrayRemove([movieId]),
      });
    } catch (e) {
      throw Exception("Failed to remove liked movie: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Error signing out: $e");
    }
  }

  Future<List<String>> getLikedMovies() async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("No user is signed in");
      }
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        final likedMovies = userDoc.data()?['likedMovies'] as List<dynamic>?;
        return likedMovies?.cast<String>() ?? [];
      } else {
        // If document does not exist, return an empty list
        return [];
      }
    } catch (e) {
      throw Exception("Failed to fetch liked movies: $e");
    }
  }
}

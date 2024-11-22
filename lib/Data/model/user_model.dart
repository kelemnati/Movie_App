class UserModel {
  final String id;
  final String email;
  final String userName;
  final List<dynamic>? likedMovies;

  UserModel(
      {required this.id,
      required this.email,
      required this.userName,
      likedMovies})
      : likedMovies = likedMovies ?? [];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        email: json['email'],
        userName: json['userName'],
        likedMovies: json['likedMovies'] ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'likedMovies': likedMovies,
    };
  }
}

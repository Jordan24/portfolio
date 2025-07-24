class User {
  final String id;
  final String? username;
  final String email;
  final String? imageUrl;

  User({
    required this.id,
    this.username,
    required this.email,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory User.fromJson(String id, Map<String, dynamic> json) {
    return User(
      id: id,
      username: json['username'] as String?,
      email: json['email'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}

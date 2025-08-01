import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class User {
  final String id;
  final String? username;
  final String email;
  final String? profileImageUrl;

  User({
    required this.id,
    this.username,
    required this.email,
    this.profileImageUrl,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      username: data['username'] as String?,
      email: data['email'] as String,
      profileImageUrl: data['profileImageUrl'] as String?,
    );
  }

  factory User.fromFirebase(firebase.User user) {
    return User(
      id: user.uid,
      username: user.displayName,
      email: user.email!,
      profileImageUrl: user.photoURL,
    );
  }
}

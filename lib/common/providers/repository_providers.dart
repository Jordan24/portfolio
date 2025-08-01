
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/common/data/auth_repository.dart';
import 'package:portfolio/common/data/user_repository.dart';
import 'package:portfolio/user/data/firebase_auth_repository.dart';
import 'package:portfolio/user/data/firebase_user_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(FirebaseAuth.instance);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return FirebaseUserRepository(FirebaseFirestore.instance, FirebaseStorage.instance);
});

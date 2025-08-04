import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/common/data/user_repository.dart';
import 'package:portfolio/user/models/user.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  FirebaseUserRepository(this._firestore, this._storage);

  @override
  Future<User> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return User.fromFirestore(doc);
  }

  @override
  Stream<User> getUserStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((
      snapshot,
    ) {
      return User.fromFirestore(snapshot);
    });
  }

  @override
  Future<void> updateUser(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toFirestore());
  }

  @override
  Future<String> uploadProfileImage(String userId, XFile image) async {
    final ref = _storage.ref().child('profile_images').child(userId);
    final metadata = SettableMetadata(contentType: image.mimeType);

    if (kIsWeb) {
      final imageData = await image.readAsBytes();
      await ref.putData(imageData, metadata);
    } else {
      await ref.putFile(File(image.path), metadata);
    }

    return await ref.getDownloadURL();
  }
}

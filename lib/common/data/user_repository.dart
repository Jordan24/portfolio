
import 'dart:io';
import 'package:portfolio/user/models/user.dart';

abstract class UserRepository {
  Future<User> getUser(String userId);
  Future<void> updateUser(User user);
  Future<String> uploadProfileImage(String userId, File image);
}

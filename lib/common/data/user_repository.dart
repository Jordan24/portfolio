import 'package:image_picker/image_picker.dart';
import 'package:portfolio/user/models/user.dart';

abstract class UserRepository {
  Stream<User> getUserStream(String userId);
  Future<User> getUser(String userId);
  Future<void> updateUser(User user);
  Future<String> uploadProfileImage(String userId, XFile image);
}

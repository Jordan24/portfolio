// Validates password length
String? isValidPassword(String? password) {
  if (password == null || password.trim().length < 8) {
    return 'Password must be at least 8 characters long.';
  }
  return null;
}

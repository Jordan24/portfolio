// Validates password length
bool isValidPassword(String? password) {
  return password != null && password.trim().length >= 8;
}

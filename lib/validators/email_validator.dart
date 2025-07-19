// Email validator checking for a valid email format
bool isValidEmail(String? email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return email != null && emailRegex.hasMatch(email);
}

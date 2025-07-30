// Email validator checking for a valid email format
String? isValidEmail(String? email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (email == null || !emailRegex.hasMatch(email)) {
    return 'Please enter a valid email address.';
  }
  return null;
}

String? validateUsername(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter a username.';
  }
  if (value.trim().length < 2) {
    return 'Username must be at least 2 characters long.';
  }
  return null;
}

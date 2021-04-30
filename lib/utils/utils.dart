String emailValidator(String email) {
  return email.trim().isNotEmpty &&
          email.contains("@") &&
          email.length > 2 &&
          email.contains(".") &&
          !email.endsWith(".")
      ? null
      : "Enter a valid email";
}

String passwordValidator(String password) {
  return password.length >= 8
      ? null
      : "password should be at least 8 characters long";
}

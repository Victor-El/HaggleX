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
      : "Password should be at least 8 characters long";
}

String usernameValidator(String username) {
  return username.trim().isNotEmpty ? null : "Username should not be empty";
}

String phoneNumberValidator(String phoneNumber) {
  return phoneNumber.trim().length > 5 ? null : "Enter a valid phone number";
}

String referralLinkValidator(String referralLink) {
  return (referralLink.trim().contains(".") &&
              referralLink.trim().contains("/") ||
          referralLink.isEmpty)
      ? null
      : "Enter a valid referral link";
}

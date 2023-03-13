String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return 'please enter a password.';
  }
  return null;
}

String? validateName(String? value) {
  const String pattern = r"^[.!#$%&'*+<>:;,%@()(/=?^_`{|}~-]";

  if (value == null || value.isEmpty) {
    return 'Name is required';
  }
  final RegExp regex = RegExp(pattern);
  if (regex.hasMatch(value)) {
    return 'Enter a valid name';
  }
  return null;
}

String? validateEmail(String? value) {
  const String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  final RegExp regex = RegExp(pattern);
  if (value == null || !regex.hasMatch(value)) {
    return 'please provide a valid email.';
  } else {
    return null;
  }
}

String? validatePhoneNumber(String? value) {
  if (value!.length < 11 || value.isEmpty) {
    return 'Phone number must be 11 characters';
  }
  if (value.isEmpty) {
    return 'Enter your phone number';
  }
  return null;
}

class Validators {
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{8,}$').hasMatch(value)) {
      return "Password must contain a capital letter and number";
    }

    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    if (value.length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }
}

String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return "Required";
  }
  if (double.tryParse(value) == null) {
    return "Enter valid number";
  }
  return null;
}

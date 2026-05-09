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

  static String? loginPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  static String? confirmPasswordValidator(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }
    if (value != password) {
      return "Passwords do not match";
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

class FarmValidators {
  static String? validateTemperature(String? value) {
    if (value == null || value.isEmpty) {
      return "Temperature is required";
    }

    final number = double.tryParse(value);

    if (number == null) {
      return "Enter valid temperature";
    }

    if (number < 17 || number > 43) {
      return "Temperature must be between 17 and 43";
    }

    return null;
  }

  static String? validateHumidity(String? value) {
    if (value == null || value.isEmpty) {
      return "Humidity is required";
    }

    final number = double.tryParse(value);

    if (number == null) {
      return "Enter valid humidity";
    }

    if (number < 36 || number > 84) {
      return "Humidity must be between 36 and 84";
    }

    return null;
  }

  static String? validatePH(String? value) {
    if (value == null || value.isEmpty) {
      return "PH is required";
    }

    final number = double.tryParse(value);

    if (number == null) {
      return "Enter valid PH";
    }

    if (number < 20 || number > 120) {
      return "PH must be between 0 and 14";
    }

    return null;
  }

  static String? validateMoisture(String? value) {
    if (value == null || value.isEmpty) {
      return "Moisture is required";
    }

    final number = double.tryParse(value);

    if (number == null) {
      return "Enter valid moisture";
    }

    if (number < 0 || number > 87) {
      return "Moisture must be between 0 and 87";
    }

    return null;
  }

  static String? validateNitrogen(String? value) {
    if (value == null || value.isEmpty) {
      return "Nitrogen is required";
    }

    final number = double.tryParse(value);

    if (number == null) {
      return "Enter valid nitrogen";
    }

    if (number < 0 || number > 44) {
      return "Nitrogen must be between 0 and 44";
    }

    return null;
  }

  static String? validatePotassium(String? value) {
    if (value == null || value.isEmpty) {
      return "Potassium is required";
    }

    final number = double.tryParse(value);

    if (number == null) {
      return "Enter valid potassium";
    }

    if (number < 0 || number > 20) {
      return "Potassium must be between 0 and 20";
    }

    return null;
  }

  static String? validatePhosphorous(String? value) {
    if (value == null || value.isEmpty) {
      return "Phosphorous is required";
    }

    final number = double.tryParse(value);

    if (number == null) {
      return "Enter valid phosphorous";
    }

    if (number < 0 || number > 45) {
      return "Phosphorous must be between 0 and 45";
    }

    return null;
  }

  static String? validateRainfall(String? value) {
    if (value == null || value.isEmpty) {
      return "Rainfall is required";
    }

    final number = double.tryParse(value);

    if (number == null) {
      return "Enter valid rainfall";
    }

    if (number < 0) {
      return "Rainfall must be positive";
    }

    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Required";
    }

    return null;
  }
}

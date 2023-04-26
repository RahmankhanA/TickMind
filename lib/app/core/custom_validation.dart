import 'package:get/get.dart';

class CustomValidation {
  static String? basicValidation({
    required String value,
    required String fieldName,
  }) {
    if (value == "") {
      return "$fieldName is required";
    } else if (value.length < 3) {
      return "$fieldName should be 3 ";
    }
    return null;
  }

  static String? descriptionValidation({
    required String value,
    required String fieldName,
  }) {
    if (value == "") {
      return "$fieldName is required";
    } else if (value.length < 10) {
      return "$fieldName length should be 10";
    }
    return null;
  }

  static String? validateName({required String name}) {
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!GetUtils.isEmail(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }
}

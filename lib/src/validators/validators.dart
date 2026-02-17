import 'package:common_ui/src/validators/regex.dart';

class AppValidators {
  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName can't be empty";
    }
    return null;
  }

  static String? regex(
    String? value,
    RegExp regex,
    String message,
  ) {
    if (value == null || value.isEmpty) return null;
    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!AppRegex.email.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? mobile(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!AppRegex.mobile.hasMatch(value)) {
      return "Please enter a valid mobile number";
    }
    return null;
  }
}

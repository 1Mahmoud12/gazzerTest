import 'package:gazzer/core/presentation/localization/l10n.dart';

class AppRegex {
  static final RegExp emailValidatorRegExp = RegExp(r"^01[0125][0-9]{8}$");
}

class Validators {
  static String? notEmpty(String? value, {String? msg}) {
    if (value == null || value.trim().isEmpty) {
      return msg ?? L10n.tr().thisFieldIsRequired;
    }
    return null;
  }

  static String? passwordValidation(String? value) {
    if (value?.isNotEmpty != true) {
      return L10n.tr().thisFieldIsRequired;
    }
    final hasMinimumLength = value!.trim().length >= 8;
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(value);
    final hasDigits = RegExp(r'[0-9]').hasMatch(value);
    final hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    if (!(hasMinimumLength || hasUpperCase || hasLowerCase || hasDigits || hasSpecialCharacters)) return null;
    String msg = "Password must contain";
    if (!hasMinimumLength) msg += " at least 8 characters, ";
    if (!hasUpperCase) msg += " one uppercase letter, ";
    if (!hasLowerCase) msg += " one lowercase letter, ";
    if (!hasDigits) msg += " one digit, ";
    if (!hasSpecialCharacters) msg += " one special character, ";
    msg = '${msg.substring(0, msg.length - 2)}.'; // replace last comma with a period
    return msg;
  }

  static String? moreThanSix(String? value) {
    if (value == null || value.trim().length < 6) {
      return L10n.tr().passwordLengthError;
    }
    return null;
  }

  static String? valueMustBeNum(String? value, int num, String name) {
    if (value == null || value.trim().length != num) {
      return L10n.tr().valueMustBeNum(num, name);
    }
    return null;
  }

  static String? valueMoreThanNum(String? value, int num, String name) {
    if (value == null || value.trim().length < num) {
      return L10n.tr().valueMoreThanNum(num, name);
    }
    return null;
  }

  static String? mobileSAValidator(String? input) {
    if (input == null || input.isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    return !RegExp(r"^5[0-9]{7}$").hasMatch(input) ? L10n.tr().invalidPhoneNumber : null;
  }

  static String? mobileEGValidator(String? input) {
    if (input == null || input.isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    return !RegExp(r"^1(0|1|2|5)[0-9]{8}$").hasMatch(input) ? L10n.tr().invalidPhoneNumber : null;
  }

  static String? emailValidator(String? input) {
    if (input == null || input.isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[^\s@]+\.[a-zA-Z]+").hasMatch(input) ? L10n.tr().invalidEmail : null;
  }

  static String? countryPhoneValidator(String? input, String code) {
    if (code == 'SA') return Validators.mobileSAValidator(input);
    if (code == 'EG') return Validators.mobileEGValidator(input);
    return Validators.valueMustBeNum(input, 5, L10n.tr().mobileNumber);
  }
}

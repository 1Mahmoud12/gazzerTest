import 'package:gazzer/core/presentation/localization/l10n.dart';

class AppRegex {
  // static final RegExp emailValidatorRegExp = RegExp(r"^01[0125][0-9]{8}$");
}

class Validators {
  static String? notEmpty(String? value, {String? msg}) {
    if (value == null || value.trim().isEmpty) {
      return msg ?? L10n.tr().thisFieldIsRequired;
    }
    return null;
  }

  static String? emailValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[^\s@]+\.[a-zA-Z]+").hasMatch(input) || input.length > 50 ? L10n.tr().invalidEmail : null;
  }

  static String? mobileEGValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    return !RegExp(r"^1(0|1|2|5)[0-9]{8}$").hasMatch(input) ? L10n.tr().invalidPhoneNumber : null;
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
    if (![hasMinimumLength, hasUpperCase, hasLowerCase, hasDigits, hasSpecialCharacters].contains(false)) return null;
    final msg = StringBuffer(L10n.tr().passwordMustConain);

    if (!hasMinimumLength) msg.write(" ${L10n.tr().atLEastEightCharacters}, ");
    if (!hasUpperCase) msg.write(" ${L10n.tr().oneUppercaseLetter}, ");
    if (!hasLowerCase) msg.write(" ${L10n.tr().oneLowercaseLetter}, ");
    if (!hasDigits) msg.write(" ${L10n.tr().oneDigit}, ");
    if (!hasSpecialCharacters) msg.write(" ${L10n.tr().oneSpecialCharacter}, ");
    var result = msg.toString();
    result = '${result.substring(0, msg.length - 2)}.'; // replace last comma with a period
    return result;
  }

  static String? dashedCharactersOnly(String? value, {String? msg}) {
    if (value == null || value.trim().isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    // if (isAr) {
    //   final hasOnlyDashes = RegExp(r'^[\u0621-\u064A -]+$').hasMatch(value);
    //   if (!hasOnlyDashes) return msg ?? L10n.tr().nameAcceptsOnlyDashedAndCharacters;
    // } else {
    //   final hasOnlyDashes = RegExp(r'^[\u0621-\u064A a-zA-Z-]+$').hasMatch(value);
    //   if (!hasOnlyDashes) return msg ?? L10n.tr().nameAcceptsOnlyDashedAndCharacters;
    // }
    final hasOnlyDashes = RegExp(r'^[\u0621-\u064A a-zA-Z-]+$').hasMatch(value);
    if (!hasOnlyDashes) {
      return msg ?? L10n.tr().nameAcceptsOnlyDashedAndCharacters;
    }
    return null;
  }

  static String? valueAtLeastNum(String? value, String name, int num) {
    if (num < 1) return null;
    if (value == null || value.trim().length < num) {
      return L10n.tr().valueMoreThanNum(num, name);
    }
    return null;
  }

  static String? valueMustBeNum(String? value, int num, String name) {
    if (value == null || value.trim().length != num) {
      return L10n.tr().valueMustBeNum(num, name);
    }
    return null;
  }

  // static String? countryPhoneValidator(String? input, String code) {
  //   if (code == 'SA') return Validators.mobileSAValidator(input);
  //   if (code == 'EG') return Validators.mobileEGValidator(input);
  //   return Validators.valueMustBeNum(input, 5, L10n.tr().mobileNumber);
  // }

  // static String? mobileSAValidator(String? input) {
  //   if (input == null || input.isEmpty) {
  //     return L10n.tr().thisFieldIsRequired;
  //   }
  //   return !RegExp(r"^5[0-9]{7}$").hasMatch(input) ? L10n.tr().invalidPhoneNumber : null;
  // }
}

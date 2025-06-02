// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get thisFieldIsRequired => 'This field is required.';

  @override
  String get passwordLengthError =>
      'Password must be at least 6 characters long.';

  @override
  String get invalidEmail => 'Please enter a valid email address.';

  @override
  String valueMustBeNum(int num, String val) {
    return '$val must be more than $num';
  }

  @override
  String get invalidPhoneNumber => 'Please enter a valid phone number.';

  @override
  String get next => 'Next';

  @override
  String get start => 'Start';

  @override
  String get hiIamGazzer => 'Hi, I am Gazzer';

  @override
  String get welcome => 'Welcome';

  @override
  String get niceToMeetYou => 'Nice to meet you';

  @override
  String get letsGo => 'Let\'s go';

  @override
  String get selectMode => 'Select Mode';

  @override
  String get guestMode => 'Guest Mode';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get or => 'Or';

  @override
  String get singUpToExploreWideVarietyOfProducts =>
      'Sign up to explore a wide variety of products';

  @override
  String get fullName => 'Full Name';

  @override
  String get yourFullName => 'Your Full Name';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get yourMobileNumber => 'Your Mobile No.';

  @override
  String get continu => 'Continue';

  @override
  String get setYourLocation => 'Set your location';

  @override
  String get healthyPlan => 'Healthy Plan';

  @override
  String get thisPartHelpYouToBeMoreHealthy =>
      'This part helps you to be more healthy';

  @override
  String get setHealthPlan => 'Set Health Plan';

  @override
  String get skip => 'Skip';

  @override
  String get loading => 'LOADING';

  @override
  String get congratulations => 'Congratulations';

  @override
  String get youMadeIt => 'You made it';

  @override
  String get chooseYourMood => 'Choose your mood';

  @override
  String get happy => 'Happy';

  @override
  String get sad => 'Sad';

  @override
  String get angry => 'Angry';

  @override
  String get excited => 'Excited';

  @override
  String get bored => 'Bored';
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @onBoarding_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get onBoarding_________________Start;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @onBoarding_________________end.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get onBoarding_________________end;

  /// No description provided for @auth___________________Start.
  ///
  /// In en, this message translates to:
  /// **'_______________________'**
  String get auth___________________Start;

  /// No description provided for @enterYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Mobile Number'**
  String get enterYourMobileNumber;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @editYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Edit Your Number'**
  String get editYourNumber;

  /// No description provided for @guestMode.
  ///
  /// In en, this message translates to:
  /// **'Guest Mode'**
  String get guestMode;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @howToLogin.
  ///
  /// In en, this message translates to:
  /// **'How to Login?'**
  String get howToLogin;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get enterYourPassword;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @anOTPhasBeenSentTo.
  ///
  /// In en, this message translates to:
  /// **'An OTP has been sent to'**
  String get anOTPhasBeenSentTo;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @enterNumDigitCodeNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter {num}-Digit code number'**
  String enterNumDigitCodeNumber(int num);

  /// No description provided for @wrongNumber.
  ///
  /// In en, this message translates to:
  /// **'Wrong Number?'**
  String get wrongNumber;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get createPassword;

  /// No description provided for @createPasswordToVerify.
  ///
  /// In en, this message translates to:
  /// **'Create Password to Verify'**
  String get createPasswordToVerify;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @yourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Your New Password'**
  String get yourNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @nameAcceptsOnlyDashedAndCharacters.
  ///
  /// In en, this message translates to:
  /// **'Name accepts only characters and dashes'**
  String get nameAcceptsOnlyDashedAndCharacters;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @pleaseReEnterYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please re-enter your new password.'**
  String get pleaseReEnterYourNewPassword;

  /// No description provided for @clickBackAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Click back again to exit'**
  String get clickBackAgainToExit;

  /// No description provided for @thisFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get thisFieldIsRequired;

  /// No description provided for @valueShouldBeNumAtelase.
  ///
  /// In en, this message translates to:
  /// **'Value {val} should be at least {num} characters'**
  String valueShouldBeNumAtelase(int num, String val);

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @valueMustBeNum.
  ///
  /// In en, this message translates to:
  /// **'{val} must be equal to {num} characters'**
  String valueMustBeNum(int num, String val);

  /// No description provided for @valueMoreThanNum.
  ///
  /// In en, this message translates to:
  /// **'Value {val} must be {num} characters or more'**
  String valueMoreThanNum(int num, String val);

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number.'**
  String get invalidPhoneNumber;

  /// No description provided for @passwordMustConain.
  ///
  /// In en, this message translates to:
  /// **'Password must contain'**
  String get passwordMustConain;

  /// No description provided for @atLEastEightCharacters.
  ///
  /// In en, this message translates to:
  /// **'at least 8 characters'**
  String get atLEastEightCharacters;

  /// No description provided for @oneUppercaseLetter.
  ///
  /// In en, this message translates to:
  /// **'one uppercase letter'**
  String get oneUppercaseLetter;

  /// No description provided for @oneLowercaseLetter.
  ///
  /// In en, this message translates to:
  /// **'one lowercase letter'**
  String get oneLowercaseLetter;

  /// No description provided for @oneSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'one special character'**
  String get oneSpecialCharacter;

  /// No description provided for @oneDigit.
  ///
  /// In en, this message translates to:
  /// **'one digit'**
  String get oneDigit;

  /// No description provided for @auth___________________End.
  ///
  /// In en, this message translates to:
  /// **'_______________________'**
  String get auth___________________End;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alert;

  /// No description provided for @areYouSureYouWantToDeleteThisItem.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get areYouSureYouWantToDeleteThisItem;

  /// No description provided for @areYouSureYouWantToClearAllItems.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all items?'**
  String get areYouSureYouWantToClearAllItems;

  /// No description provided for @areYouSureYouWantToLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureYouWantToLogout;

  /// No description provided for @areYouSureYouWantToDeleteThisAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this account?'**
  String get areYouSureYouWantToDeleteThisAccount;

  /// No description provided for @pressDoubleBackToExit.
  ///
  /// In en, this message translates to:
  /// **'Press double back to exit'**
  String get pressDoubleBackToExit;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @requestTimeOut.
  ///
  /// In en, this message translates to:
  /// **'Request timed out'**
  String get requestTimeOut;

  /// No description provided for @weakOrNoInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Weak or no internet connection'**
  String get weakOrNoInternetConnection;

  /// No description provided for @requestToServerWasCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request to server was cancelled'**
  String get requestToServerWasCancelled;

  /// No description provided for @unknownErorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Unknown error occurred'**
  String get unknownErorOccurred;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @hiIamGazzer.
  ///
  /// In en, this message translates to:
  /// **'Hi, I am Gazzer'**
  String get hiIamGazzer;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @niceToMeetYou.
  ///
  /// In en, this message translates to:
  /// **'Nice to meet you'**
  String get niceToMeetYou;

  /// No description provided for @letsGo.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go'**
  String get letsGo;

  /// No description provided for @selectMode.
  ///
  /// In en, this message translates to:
  /// **'Select Mode'**
  String get selectMode;

  /// No description provided for @singUpToExploreWideVarietyOfProducts.
  ///
  /// In en, this message translates to:
  /// **'Sign up to explore a wide variety of products'**
  String get singUpToExploreWideVarietyOfProducts;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @yourFullName.
  ///
  /// In en, this message translates to:
  /// **'Your Full Name'**
  String get yourFullName;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @yourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Your Mobile No.'**
  String get yourMobileNumber;

  /// No description provided for @continu.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continu;

  /// No description provided for @setYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Set your location'**
  String get setYourLocation;

  /// No description provided for @healthyPlan.
  ///
  /// In en, this message translates to:
  /// **'Healthy Plan'**
  String get healthyPlan;

  /// No description provided for @thisPartHelpYouToBeMoreHealthy.
  ///
  /// In en, this message translates to:
  /// **'This part helps you to be more healthy'**
  String get thisPartHelpYouToBeMoreHealthy;

  /// No description provided for @setHealthPlan.
  ///
  /// In en, this message translates to:
  /// **'Set Health Plan'**
  String get setHealthPlan;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'LOADING'**
  String get loading;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// No description provided for @youMadeIt.
  ///
  /// In en, this message translates to:
  /// **'You made it'**
  String get youMadeIt;

  /// No description provided for @chooseYourMood.
  ///
  /// In en, this message translates to:
  /// **'Choose your mood'**
  String get chooseYourMood;

  /// No description provided for @happy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get happy;

  /// No description provided for @sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sad;

  /// No description provided for @angry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get angry;

  /// No description provided for @excited.
  ///
  /// In en, this message translates to:
  /// **'Excited'**
  String get excited;

  /// No description provided for @bored.
  ///
  /// In en, this message translates to:
  /// **'Bored'**
  String get bored;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

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
/// import 'l10n/app_localizations.dart';
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
    Locale('en')
  ];

  /// No description provided for @new_________________________________________________________.
  ///
  /// In en, this message translates to:
  /// **'_________________________________________________________'**
  String get new_________________________________________________________;

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

  /// No description provided for @requestTimeOut.
  ///
  /// In en, this message translates to:
  /// **'Request time out'**
  String get requestTimeOut;

  /// No description provided for @pleaseCheckYourInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection'**
  String get pleaseCheckYourInternetConnection;

  /// No description provided for @tryToConnect.
  ///
  /// In en, this message translates to:
  /// **'Try to connect'**
  String get tryToConnect;

  /// No description provided for @econsult.
  ///
  /// In en, this message translates to:
  /// **'eConsult'**
  String get econsult;

  /// No description provided for @askDoctor.
  ///
  /// In en, this message translates to:
  /// **'Ask doctor'**
  String get askDoctor;

  /// No description provided for @searchForAnything.
  ///
  /// In en, this message translates to:
  /// **'Search for anything'**
  String get searchForAnything;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Wlecome Back'**
  String get welcomeBack;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get passwordConfirm;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up '**
  String get signUp;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @pressHere.
  ///
  /// In en, this message translates to:
  /// **'Press here'**
  String get pressHere;

  /// No description provided for @signupWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Enjoy reading many books'**
  String get signupWelcomeMessage;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLess;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// No description provided for @discription.
  ///
  /// In en, this message translates to:
  /// **'Discription'**
  String get discription;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @checkYourEmailAndEnterCode.
  ///
  /// In en, this message translates to:
  /// **'Check your email and enter the code'**
  String get checkYourEmailAndEnterCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @pressDoubleBackToExit.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get pressDoubleBackToExit;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @pleaseLoginFirst.
  ///
  /// In en, this message translates to:
  /// **'Please Login First'**
  String get pleaseLoginFirst;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create An Account'**
  String get createAnAccount;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get createNewAccount;

  /// No description provided for @enterYourDetailsToCreateAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Enter your details to create an account'**
  String get enterYourDetailsToCreateAnAccount;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @enterYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Endter Your Number'**
  String get enterYourNumber;

  /// No description provided for @toKeepConnectedWithUsPleaseLoginWithYourInfo.
  ///
  /// In en, this message translates to:
  /// **'To keep connected with us please login with your account info'**
  String get toKeepConnectedWithUsPleaseLoginWithYourInfo;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @verfiyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Verfiy phone number'**
  String get verfiyPhoneNumber;

  /// No description provided for @weHaveSentYouOnSMSWithCodeToThisNumber.
  ///
  /// In en, this message translates to:
  /// **'We have sent you an SMS with a code to this number'**
  String get weHaveSentYouOnSMSWithCodeToThisNumber;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @thisFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get thisFieldIsRequired;

  /// No description provided for @passwordLengthError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordLengthError;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneNumber;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @youCanRequestNewCodeIn.
  ///
  /// In en, this message translates to:
  /// **'You can request a new code in'**
  String get youCanRequestNewCodeIn;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @continueAsAGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as a guest'**
  String get continueAsAGuest;

  /// No description provided for @toKeepConnectedWithUsPleaseRegisterWithYourInfo.
  ///
  /// In en, this message translates to:
  /// **'To keep connected with us please register with your account info'**
  String get toKeepConnectedWithUsPleaseRegisterWithYourInfo;

  /// No description provided for @flullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get flullName;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birthDate;

  /// No description provided for @idIqama.
  ///
  /// In en, this message translates to:
  /// **'ID/Iqama'**
  String get idIqama;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get completeYourProfile;

  /// No description provided for @enterBirthday.
  ///
  /// In en, this message translates to:
  /// **'Enter birthday'**
  String get enterBirthday;

  /// No description provided for @pleaseEnterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter verification code'**
  String get pleaseEnterVerificationCode;

  /// No description provided for @welcomeToKurePleaseTellUsMoreAboutYou.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Kure, please tell us more about you'**
  String get welcomeToKurePleaseTellUsMoreAboutYou;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @itemAddedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Item Added To Favorites'**
  String get itemAddedToFavorites;

  /// No description provided for @itemRemovedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Item Removed From Favorites'**
  String get itemRemovedFromFavorites;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @thisProductIsReturnable.
  ///
  /// In en, this message translates to:
  /// **'This product is returnable'**
  String get thisProductIsReturnable;

  /// No description provided for @thisProductIsNotReturnableOrExchangeable.
  ///
  /// In en, this message translates to:
  /// **'This product is not returnable or exchangeable'**
  String get thisProductIsNotReturnableOrExchangeable;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get inStock;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get outOfStock;

  /// No description provided for @itemAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Item added to cart'**
  String get itemAddedToCart;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @howToUseThisProduct.
  ///
  /// In en, this message translates to:
  /// **'How to use this product'**
  String get howToUseThisProduct;

  /// No description provided for @taxIncluded.
  ///
  /// In en, this message translates to:
  /// **'Tax included'**
  String get taxIncluded;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @commingSoon.
  ///
  /// In en, this message translates to:
  /// **'Comming soon'**
  String get commingSoon;

  /// No description provided for @stayTuned.
  ///
  /// In en, this message translates to:
  /// **'Stay tuned'**
  String get stayTuned;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get allCategories;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @saveForLater.
  ///
  /// In en, this message translates to:
  /// **'Save for later'**
  String get saveForLater;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @drRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Dr Recommendation'**
  String get drRecommendation;

  /// No description provided for @prescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get prescription;

  /// No description provided for @itemWillBeAddedToFavoritesAndRemovedFromCart.
  ///
  /// In en, this message translates to:
  /// **'Item will be added to favorites and removed from cart'**
  String get itemWillBeAddedToFavoritesAndRemovedFromCart;

  /// No description provided for @areYouSureYouWantToDeleteThisItem.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get areYouSureYouWantToDeleteThisItem;

  /// No description provided for @areYouSureYouWantToDeleteAllItems.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all items?'**
  String get areYouSureYouWantToDeleteAllItems;

  /// No description provided for @attention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attention;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @productsSummary.
  ///
  /// In en, this message translates to:
  /// **'Products Summary'**
  String get productsSummary;

  /// No description provided for @deliveryTo.
  ///
  /// In en, this message translates to:
  /// **'Delivery to'**
  String get deliveryTo;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @deliveryWithin.
  ///
  /// In en, this message translates to:
  /// **'Delivery within'**
  String get deliveryWithin;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo code'**
  String get promoCode;

  /// No description provided for @enterYourPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Enter your promo code'**
  String get enterYourPromoCode;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @netTotal.
  ///
  /// In en, this message translates to:
  /// **'Net Total'**
  String get netTotal;

  /// No description provided for @deliveryFees.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fees'**
  String get deliveryFees;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @applPay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get applPay;

  /// No description provided for @creditDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Credit/Debit Card'**
  String get creditDebitCard;

  /// No description provided for @mada.
  ///
  /// In en, this message translates to:
  /// **'Mada'**
  String get mada;

  /// No description provided for @tabby.
  ///
  /// In en, this message translates to:
  /// **'Tabby'**
  String get tabby;

  /// No description provided for @tamara.
  ///
  /// In en, this message translates to:
  /// **'Tamara'**
  String get tamara;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmOrder;

  /// No description provided for @includingVAT.
  ///
  /// In en, this message translates to:
  /// **'Including VAT'**
  String get includingVAT;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order number'**
  String get orderNumber;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'QTY'**
  String get quantity;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @addresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addresses;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @homeAddress.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeAddress;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @youDonnotHaveAnyAddresses.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any addresses'**
  String get youDonnotHaveAnyAddresses;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// No description provided for @editAddress.
  ///
  /// In en, this message translates to:
  /// **'Edit Address'**
  String get editAddress;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// No description provided for @addressDetails.
  ///
  /// In en, this message translates to:
  /// **'Address Details'**
  String get addressDetails;

  /// No description provided for @buildingNumber.
  ///
  /// In en, this message translates to:
  /// **'Building Number'**
  String get buildingNumber;

  /// No description provided for @floorNumber.
  ///
  /// In en, this message translates to:
  /// **'Floor Number'**
  String get floorNumber;

  /// No description provided for @apartmentNumber.
  ///
  /// In en, this message translates to:
  /// **'Apartment Number'**
  String get apartmentNumber;

  /// No description provided for @defaultAddress.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultAddress;

  /// No description provided for @markAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Mark as Default'**
  String get markAsDefault;

  /// No description provided for @addressAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Address added successfully'**
  String get addressAddedSuccessfully;

  /// No description provided for @addressUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Address updated successfully'**
  String get addressUpdatedSuccessfully;

  /// No description provided for @areYouSureYouWantToDeleteThisAddress.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this address?'**
  String get areYouSureYouWantToDeleteThisAddress;

  /// No description provided for @addressDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Address deleted successfully'**
  String get addressDeletedSuccessfully;

  /// No description provided for @pleaseSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Please select location'**
  String get pleaseSelectLocation;

  /// No description provided for @selectAddress.
  ///
  /// In en, this message translates to:
  /// **'Select Address'**
  String get selectAddress;

  /// No description provided for @pleaseSelectAddress.
  ///
  /// In en, this message translates to:
  /// **'Please select address'**
  String get pleaseSelectAddress;

  /// No description provided for @promoCodeAppliedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Promo code applied successfully'**
  String get promoCodeAppliedSuccessfully;

  /// No description provided for @promoCodeisNotValid.
  ///
  /// In en, this message translates to:
  /// **'Promo code is not valid'**
  String get promoCodeisNotValid;

  /// No description provided for @orderCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order created successfully'**
  String get orderCreatedSuccessfully;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @yourOrderHasBeenCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your order has been created successfully'**
  String get yourOrderHasBeenCreatedSuccessfully;

  /// No description provided for @orderCreationFailed.
  ///
  /// In en, this message translates to:
  /// **'Order creation failed'**
  String get orderCreationFailed;

  /// No description provided for @youWillBeTransferredAutomaticallyIn.
  ///
  /// In en, this message translates to:
  /// **'You will be transferred automatically in'**
  String get youWillBeTransferredAutomaticallyIn;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @orderNote.
  ///
  /// In en, this message translates to:
  /// **'Order note'**
  String get orderNote;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add note'**
  String get addNote;

  /// No description provided for @areYouSureYouWantToLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureYouWantToLogout;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @thereAreNoProductsInYourCart.
  ///
  /// In en, this message translates to:
  /// **'There are no products in your cart'**
  String get thereAreNoProductsInYourCart;

  /// No description provided for @discoverOurProducts.
  ///
  /// In en, this message translates to:
  /// **'Discover our products'**
  String get discoverOurProducts;

  /// No description provided for @checkProducts.
  ///
  /// In en, this message translates to:
  /// **'Check products'**
  String get checkProducts;

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @outForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for delivery'**
  String get outForDelivery;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @refunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get refunded;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @onlinePayment.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get onlinePayment;

  /// No description provided for @youHaveNoPreviousOrders.
  ///
  /// In en, this message translates to:
  /// **'You have no previous orders'**
  String get youHaveNoPreviousOrders;

  /// No description provided for @youHaveNoFavoriteItems.
  ///
  /// In en, this message translates to:
  /// **'You have no favorite items'**
  String get youHaveNoFavoriteItems;

  /// No description provided for @areYouSureYouWantToClearYourFavorites.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear your favorites'**
  String get areYouSureYouWantToClearYourFavorites;

  /// No description provided for @youHaveNoNotifications.
  ///
  /// In en, this message translates to:
  /// **'You have no notifications'**
  String get youHaveNoNotifications;

  /// No description provided for @youHaveNoPaymentCards.
  ///
  /// In en, this message translates to:
  /// **'You have no payment cards'**
  String get youHaveNoPaymentCards;

  /// No description provided for @yourProfileHasBeenUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your profile has been updated successfully'**
  String get yourProfileHasBeenUpdatedSuccessfully;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get orderItems;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatus;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @atLeastOneAddressShouldBeDefault.
  ///
  /// In en, this message translates to:
  /// **'At least one address should be default'**
  String get atLeastOneAddressShouldBeDefault;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @itemPrice.
  ///
  /// In en, this message translates to:
  /// **'Item Price'**
  String get itemPrice;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @requiresPrescription.
  ///
  /// In en, this message translates to:
  /// **'Requires Prescription'**
  String get requiresPrescription;

  /// No description provided for @reviewOrder.
  ///
  /// In en, this message translates to:
  /// **'Review Order'**
  String get reviewOrder;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @giveRatingToThisProduct.
  ///
  /// In en, this message translates to:
  /// **'Give rating to this product'**
  String get giveRatingToThisProduct;

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// No description provided for @areYouSureYouWantToCancelThisOrder.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order'**
  String get areYouSureYouWantToCancelThisOrder;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @thisActionWillClearYourCurrentCartItems.
  ///
  /// In en, this message translates to:
  /// **'This action will clear your current cart items'**
  String get thisActionWillClearYourCurrentCartItems;

  /// No description provided for @weAreUnderMaintainance.
  ///
  /// In en, this message translates to:
  /// **'We are under maintainance'**
  String get weAreUnderMaintainance;

  /// No description provided for @willBeBackSoon.
  ///
  /// In en, this message translates to:
  /// **'Will be back soon'**
  String get willBeBackSoon;

  /// No description provided for @maxAllowedsizeIs.
  ///
  /// In en, this message translates to:
  /// **'Max allowed size is {num} MB'**
  String maxAllowedsizeIs(int num);

  /// No description provided for @youWillGainPointsForEachItemReview.
  ///
  /// In en, this message translates to:
  /// **'You will gain {num} points for each item review'**
  String youWillGainPointsForEachItemReview(int num);

  /// No description provided for @youAreGivingRateToItem.
  ///
  /// In en, this message translates to:
  /// **'You are giving rate {num} to item {name}'**
  String youAreGivingRateToItem(int num, String name);

  /// No description provided for @valueMustBeNum.
  ///
  /// In en, this message translates to:
  /// **'{val} must be {num} characters'**
  String valueMustBeNum(int num, String val);

  /// No description provided for @ratingCannotBeChangedLater.
  ///
  /// In en, this message translates to:
  /// **'Rating cannot be changed later'**
  String get ratingCannotBeChangedLater;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @chooseImageFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose image from gallery'**
  String get chooseImageFromGallery;

  /// No description provided for @deleteYourImage.
  ///
  /// In en, this message translates to:
  /// **'Delete your image'**
  String get deleteYourImage;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @areYouSureYouWantToDeleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account'**
  String get areYouSureYouWantToDeleteYourAccount;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get productNotFound;

  /// No description provided for @expressDelivery.
  ///
  /// In en, this message translates to:
  /// **'Express delivery'**
  String get expressDelivery;

  /// No description provided for @standardDelivery.
  ///
  /// In en, this message translates to:
  /// **'Standard delivery'**
  String get standardDelivery;

  /// No description provided for @deliveryType.
  ///
  /// In en, this message translates to:
  /// **'Delivery type'**
  String get deliveryType;

  /// No description provided for @sameDayDelivery.
  ///
  /// In en, this message translates to:
  /// **'Same day delivery'**
  String get sameDayDelivery;

  /// No description provided for @nextDayDelivery.
  ///
  /// In en, this message translates to:
  /// **'Next day delivery'**
  String get nextDayDelivery;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @fees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get fees;

  /// No description provided for @freeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Free delivery'**
  String get freeDelivery;

  /// No description provided for @youHaveGotFreeDelivery.
  ///
  /// In en, this message translates to:
  /// **'You have got free delivery'**
  String get youHaveGotFreeDelivery;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cashOnDelivery;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @writeYouMessage.
  ///
  /// In en, this message translates to:
  /// **'Write you message'**
  String get writeYouMessage;

  /// No description provided for @weReallyCareToHearFromYou.
  ///
  /// In en, this message translates to:
  /// **'We really care to hear from you'**
  String get weReallyCareToHearFromYou;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @weCurrentlyNotDeliveringToThisAddress.
  ///
  /// In en, this message translates to:
  /// **'We currently not delivering to this address'**
  String get weCurrentlyNotDeliveringToThisAddress;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFound;

  /// No description provided for @onlineConsultation.
  ///
  /// In en, this message translates to:
  /// **'Online consultation'**
  String get onlineConsultation;

  /// No description provided for @waitingForOtherParticipant.
  ///
  /// In en, this message translates to:
  /// **'Waiting for other participant'**
  String get waitingForOtherParticipant;

  /// No description provided for @exitingTheScreenWillEndTheCall.
  ///
  /// In en, this message translates to:
  /// **'Exiting the screen will end the call'**
  String get exitingTheScreenWillEndTheCall;

  /// No description provided for @startConsultation.
  ///
  /// In en, this message translates to:
  /// **'Start consultation'**
  String get startConsultation;

  /// No description provided for @enableCamera.
  ///
  /// In en, this message translates to:
  /// **'Enable camera'**
  String get enableCamera;

  /// No description provided for @enableMicrophone.
  ///
  /// In en, this message translates to:
  /// **'Enable microphone'**
  String get enableMicrophone;

  /// No description provided for @pleaseBeInformedThatThisSessionWillBeRecordedForQualityAssurance.
  ///
  /// In en, this message translates to:
  /// **'Please be informed that this session will be recorded for quality assurance'**
  String get pleaseBeInformedThatThisSessionWillBeRecordedForQualityAssurance;

  /// No description provided for @startSession.
  ///
  /// In en, this message translates to:
  /// **'Start session'**
  String get startSession;

  /// No description provided for @sessionIsInitializedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Session is initialized successfully'**
  String get sessionIsInitializedSuccessfully;

  /// No description provided for @theOtherMebmerOfTheCallHasMutedHisMic.
  ///
  /// In en, this message translates to:
  /// **'The other call member has muted his mic'**
  String get theOtherMebmerOfTheCallHasMutedHisMic;

  /// No description provided for @theOtherMebmerOfTheCallHasUnmutedHisMic.
  ///
  /// In en, this message translates to:
  /// **'The other call member has unmuted his mic'**
  String get theOtherMebmerOfTheCallHasUnmutedHisMic;

  /// No description provided for @theOtherMebmerOfTheCallHasTurnedOffHisCamera.
  ///
  /// In en, this message translates to:
  /// **'The other call member has turned off his camera'**
  String get theOtherMebmerOfTheCallHasTurnedOffHisCamera;

  /// No description provided for @theOtherMebmerOfTheCallHasTurnedOnHisCamera.
  ///
  /// In en, this message translates to:
  /// **'The other call member has turned on his camera'**
  String get theOtherMebmerOfTheCallHasTurnedOnHisCamera;

  /// No description provided for @doctorApp_______________________________.
  ///
  /// In en, this message translates to:
  /// **'doctorApp_______________________________'**
  String get doctorApp_______________________________;

  /// No description provided for @reservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get reservations;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'availability'**
  String get availability;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @appointmentTime.
  ///
  /// In en, this message translates to:
  /// **'Appointment Time'**
  String get appointmentTime;

  /// No description provided for @addDaysAndHoursOfYourAvailability.
  ///
  /// In en, this message translates to:
  /// **'Add days and hours of your availability'**
  String get addDaysAndHoursOfYourAvailability;

  /// No description provided for @vaccationMode.
  ///
  /// In en, this message translates to:
  /// **'Vaccation Mode'**
  String get vaccationMode;

  /// No description provided for @addAnotherPeriod.
  ///
  /// In en, this message translates to:
  /// **'Add another period'**
  String get addAnotherPeriod;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @updateBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Update bank account'**
  String get updateBankAccount;

  /// No description provided for @bankAccount.
  ///
  /// In en, this message translates to:
  /// **'Bank account'**
  String get bankAccount;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @swiftCode.
  ///
  /// In en, this message translates to:
  /// **'Swift code'**
  String get swiftCode;

  /// No description provided for @iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get iban;

  /// No description provided for @myCredit.
  ///
  /// In en, this message translates to:
  /// **'My credit'**
  String get myCredit;

  /// No description provided for @yourBalanceIs.
  ///
  /// In en, this message translates to:
  /// **'Your balance is'**
  String get yourBalanceIs;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @addMoney.
  ///
  /// In en, this message translates to:
  /// **'Add money'**
  String get addMoney;

  /// No description provided for @cashbackBalance.
  ///
  /// In en, this message translates to:
  /// **'Cashback balance'**
  String get cashbackBalance;

  /// No description provided for @shareProfile.
  ///
  /// In en, this message translates to:
  /// **'Share profile'**
  String get shareProfile;

  /// No description provided for @yearsOld.
  ///
  /// In en, this message translates to:
  /// **'Years old'**
  String get yearsOld;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @personalData.
  ///
  /// In en, this message translates to:
  /// **'Personal data'**
  String get personalData;

  /// No description provided for @contactData.
  ///
  /// In en, this message translates to:
  /// **'Contact data'**
  String get contactData;

  /// No description provided for @medicalLicenseNum.
  ///
  /// In en, this message translates to:
  /// **'Medical license number'**
  String get medicalLicenseNum;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @fellowship.
  ///
  /// In en, this message translates to:
  /// **'Fellowship'**
  String get fellowship;

  /// No description provided for @awards.
  ///
  /// In en, this message translates to:
  /// **'Awards'**
  String get awards;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get aboutMe;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @sessionComplete.
  ///
  /// In en, this message translates to:
  /// **'Your session with {doctorName} is complete! 🎉'**
  String sessionComplete(String doctorName);

  /// No description provided for @kindlyWriteYourNotes.
  ///
  /// In en, this message translates to:
  /// **'Kindly Write your Notes'**
  String get kindlyWriteYourNotes;

  /// No description provided for @daysForMedicineEffectiveness.
  ///
  /// In en, this message translates to:
  /// **'# of Days Medicine to be effective?'**
  String get daysForMedicineEffectiveness;

  /// No description provided for @userHairType.
  ///
  /// In en, this message translates to:
  /// **'User Hair Type?'**
  String get userHairType;

  /// No description provided for @userSkinType.
  ///
  /// In en, this message translates to:
  /// **'User Skin Type?'**
  String get userSkinType;

  /// No description provided for @drNotes.
  ///
  /// In en, this message translates to:
  /// **'Dr Notes'**
  String get drNotes;

  /// No description provided for @writeYourNotesHere.
  ///
  /// In en, this message translates to:
  /// **'Write your Notes here'**
  String get writeYourNotesHere;

  /// No description provided for @instantConsultation.
  ///
  /// In en, this message translates to:
  /// **'Instant Consultation'**
  String get instantConsultation;

  /// No description provided for @bookConsultationInTenMinutes.
  ///
  /// In en, this message translates to:
  /// **'Book consultation in 10 minutes'**
  String get bookConsultationInTenMinutes;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @firstAvailability.
  ///
  /// In en, this message translates to:
  /// **'First Availability'**
  String get firstAvailability;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @selectYourAppointment.
  ///
  /// In en, this message translates to:
  /// **'Select your appointment'**
  String get selectYourAppointment;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get selectTime;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @basedOnNumReviews.
  ///
  /// In en, this message translates to:
  /// **'Based on {num} reviews'**
  String basedOnNumReviews(int num);

  /// No description provided for @requestAnAppointment.
  ///
  /// In en, this message translates to:
  /// **'Request an appointment'**
  String get requestAnAppointment;

  /// No description provided for @leaveANoteForTheDoctor.
  ///
  /// In en, this message translates to:
  /// **'Leave a note for the doctor'**
  String get leaveANoteForTheDoctor;

  /// No description provided for @uploadAttachements.
  ///
  /// In en, this message translates to:
  /// **'Upload attachements'**
  String get uploadAttachements;

  /// No description provided for @uploadUpToNumImages.
  ///
  /// In en, this message translates to:
  /// **'upload up to {num} images'**
  String uploadUpToNumImages(int num);

  /// No description provided for @uploadUpToNumMB.
  ///
  /// In en, this message translates to:
  /// **'upload up to {num} MB'**
  String uploadUpToNumMB(int num);

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @yourAppointmentHasBeenReservedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been reserved successfully'**
  String get yourAppointmentHasBeenReservedSuccessfully;

  /// No description provided for @youCannotCancelThisAppointment.
  ///
  /// In en, this message translates to:
  /// **'You cannot cancel this appointment'**
  String get youCannotCancelThisAppointment;

  /// No description provided for @appointmentsCanNotBeCancelledNumHoursOrLessBeforeTheAppointment.
  ///
  /// In en, this message translates to:
  /// **'Appointments can not be cancelled {num} hours or less before the appointment'**
  String appointmentsCanNotBeCancelledNumHoursOrLessBeforeTheAppointment(
      int num);

  /// No description provided for @areYouSureYouWantToCancelThisAppointment.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this appointment?'**
  String get areYouSureYouWantToCancelThisAppointment;

  /// No description provided for @noKeep.
  ///
  /// In en, this message translates to:
  /// **'No, keep'**
  String get noKeep;

  /// No description provided for @yesCanel.
  ///
  /// In en, this message translates to:
  /// **'Yes, cancel'**
  String get yesCanel;

  /// No description provided for @appointmentCancelledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Appointment cancelled successfully'**
  String get appointmentCancelledSuccessfully;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @noteForTheDoctor.
  ///
  /// In en, this message translates to:
  /// **'Note for the doctor'**
  String get noteForTheDoctor;

  /// No description provided for @clientAttachments.
  ///
  /// In en, this message translates to:
  /// **'Client Attachments'**
  String get clientAttachments;

  /// No description provided for @doctorNotesAndAttachements.
  ///
  /// In en, this message translates to:
  /// **'Doctor Notes and Attachements'**
  String get doctorNotesAndAttachements;

  /// No description provided for @itemsAddedByDoctor.
  ///
  /// In en, this message translates to:
  /// **'Items added by doctor'**
  String get itemsAddedByDoctor;

  /// No description provided for @bookDoctorAgain.
  ///
  /// In en, this message translates to:
  /// **'Book doctor again'**
  String get bookDoctorAgain;

  /// No description provided for @reservationDetails.
  ///
  /// In en, this message translates to:
  /// **'Reservation Details'**
  String get reservationDetails;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @multipleImages.
  ///
  /// In en, this message translates to:
  /// **'Miltiple Images'**
  String get multipleImages;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @alwaysAvailable.
  ///
  /// In en, this message translates to:
  /// **'Always available'**
  String get alwaysAvailable;

  /// No description provided for @lettingYourSelfAlwaysAvailableWillLetPatientsBookWithYouAnyTime.
  ///
  /// In en, this message translates to:
  /// **'Letting your self always available will let patients book with you any time'**
  String get lettingYourSelfAlwaysAvailableWillLetPatientsBookWithYouAnyTime;

  /// No description provided for @joinAsDoctor.
  ///
  /// In en, this message translates to:
  /// **'Join as a Doctor'**
  String get joinAsDoctor;

  /// No description provided for @professionalData.
  ///
  /// In en, this message translates to:
  /// **'Professional data'**
  String get professionalData;

  /// No description provided for @addField.
  ///
  /// In en, this message translates to:
  /// **'Add field'**
  String get addField;

  /// No description provided for @awardName.
  ///
  /// In en, this message translates to:
  /// **'Award name'**
  String get awardName;

  /// No description provided for @maxAllowedNumberOfFiles.
  ///
  /// In en, this message translates to:
  /// **'Max allowed number of files is {num}'**
  String maxAllowedNumberOfFiles(int num);

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @multipleFiles.
  ///
  /// In en, this message translates to:
  /// **'Multiple Files'**
  String get multipleFiles;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @addAttachment.
  ///
  /// In en, this message translates to:
  /// **'Add attachment'**
  String get addAttachment;

  /// No description provided for @speciality.
  ///
  /// In en, this message translates to:
  /// **'Speciality'**
  String get speciality;

  /// No description provided for @pleaseAttachTheFollowing.
  ///
  /// In en, this message translates to:
  /// **'Please attach the following'**
  String get pleaseAttachTheFollowing;

  /// No description provided for @medicalLicense.
  ///
  /// In en, this message translates to:
  /// **'Medical license'**
  String get medicalLicense;

  /// No description provided for @iD.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get iD;

  /// No description provided for @graduationCertificate.
  ///
  /// In en, this message translates to:
  /// **'Graduation certificate'**
  String get graduationCertificate;

  /// No description provided for @fellowshipCertificate.
  ///
  /// In en, this message translates to:
  /// **'Fellowship certificate'**
  String get fellowshipCertificate;

  /// No description provided for @syndicateID.
  ///
  /// In en, this message translates to:
  /// **'Syndicate ID'**
  String get syndicateID;

  /// No description provided for @proofOfYourFellowshipIfPresent.
  ///
  /// In en, this message translates to:
  /// **'Proof of your fellowship if present'**
  String get proofOfYourFellowshipIfPresent;

  /// No description provided for @proofOfYourAwardsIfPresent.
  ///
  /// In en, this message translates to:
  /// **'Proof of your awards if present'**
  String get proofOfYourAwardsIfPresent;

  /// No description provided for @pleaseAddTheRequiredAttachments.
  ///
  /// In en, this message translates to:
  /// **'Please add the required attachments'**
  String get pleaseAddTheRequiredAttachments;

  /// No description provided for @yourRequestHasBeenSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your request has been submitted successfully'**
  String get yourRequestHasBeenSubmittedSuccessfully;

  /// No description provided for @underReview.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get underReview;

  /// No description provided for @yourRequestHasBeenSubmittedAndIsCurrentlyUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Your request has been submitted and is currently under review'**
  String get yourRequestHasBeenSubmittedAndIsCurrentlyUnderReview;

  /// No description provided for @weWillNotifyYouOnceAdecisionHasBeenMadeThankYouForYourPatience.
  ///
  /// In en, this message translates to:
  /// **'We will notify you once a decision has been made. Thank you for your patience'**
  String get weWillNotifyYouOnceAdecisionHasBeenMadeThankYouForYourPatience;

  /// No description provided for @ifYouHaveAnyQuestionsPleaseContactUs.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions please contact us'**
  String get ifYouHaveAnyQuestionsPleaseContactUs;

  /// No description provided for @requestHasBeenRejected.
  ///
  /// In en, this message translates to:
  /// **'Request has been rejected'**
  String get requestHasBeenRejected;

  /// No description provided for @weareSorryToInformYouThatYourRequestHasBeenRejected.
  ///
  /// In en, this message translates to:
  /// **'we are sorry to inform you that your request has been rejected'**
  String get weareSorryToInformYouThatYourRequestHasBeenRejected;

  /// No description provided for @followingAreTheReasonsForRejection.
  ///
  /// In en, this message translates to:
  /// **'Following are the reasons for rejection'**
  String get followingAreTheReasonsForRejection;

  /// No description provided for @submitNewRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit new request'**
  String get submitNewRequest;

  /// No description provided for @yourRequestHasBeenApproved.
  ///
  /// In en, this message translates to:
  /// **'Your request has been approved'**
  String get yourRequestHasBeenApproved;

  /// No description provided for @weArePleasedToHaveYouInOurTeam.
  ///
  /// In en, this message translates to:
  /// **'we are pleased to have you in our team'**
  String get weArePleasedToHaveYouInOurTeam;

  /// No description provided for @startAsADoctor.
  ///
  /// In en, this message translates to:
  /// **'Start as a doctor'**
  String get startAsADoctor;

  /// No description provided for @placeHolder.
  ///
  /// In en, this message translates to:
  /// **'Place holder'**
  String get placeHolder;

  /// No description provided for @otpIsResent.
  ///
  /// In en, this message translates to:
  /// **'OTP is resent'**
  String get otpIsResent;

  /// No description provided for @maxPArticiantsNumberExceeded.
  ///
  /// In en, this message translates to:
  /// **'Max participants number exceeded'**
  String get maxPArticiantsNumberExceeded;

  /// No description provided for @youAreAlreadyAttendingThisSession.
  ///
  /// In en, this message translates to:
  /// **'You are already attending this session'**
  String get youAreAlreadyAttendingThisSession;

  /// No description provided for @youCanOnlyJoinASessionWithOneDevice.
  ///
  /// In en, this message translates to:
  /// **'You can only join a session with one device'**
  String get youCanOnlyJoinASessionWithOneDevice;

  /// No description provided for @mySchedule.
  ///
  /// In en, this message translates to:
  /// **'My Schedule'**
  String get mySchedule;

  /// No description provided for @clientName.
  ///
  /// In en, this message translates to:
  /// **'Client Name'**
  String get clientName;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @markDayAsVacation.
  ///
  /// In en, this message translates to:
  /// **'Mark day as vacation'**
  String get markDayAsVacation;
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
      'that was used.');
}

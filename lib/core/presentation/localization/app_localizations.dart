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

  /// No description provided for @groceries_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get groceries_________________Start;

  /// No description provided for @bestOffer.
  ///
  /// In en, this message translates to:
  /// **'Best Offer'**
  String get bestOffer;

  /// No description provided for @shopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shopNow;

  /// No description provided for @groceryStores.
  ///
  /// In en, this message translates to:
  /// **'Grocery Stores'**
  String get groceryStores;

  /// No description provided for @groceries_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get groceries_________________End;

  /// No description provided for @ordersHistory_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get ordersHistory_________________Start;

  /// No description provided for @historyOrders.
  ///
  /// In en, this message translates to:
  /// **'History Orders'**
  String get historyOrders;

  /// No description provided for @recentOrders.
  ///
  /// In en, this message translates to:
  /// **'Recent Orders'**
  String get recentOrders;

  /// No description provided for @ordersHistory_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get ordersHistory_________________End;

  /// No description provided for @restaurants_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get restaurants_________________Start;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @todayPicks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Picks'**
  String get todayPicks;

  /// No description provided for @exploreBest.
  ///
  /// In en, this message translates to:
  /// **'Explore Best'**
  String get exploreBest;

  /// No description provided for @pickToYou.
  ///
  /// In en, this message translates to:
  /// **'Pick To You'**
  String get pickToYou;

  /// No description provided for @eartYourFirstOrderForFree.
  ///
  /// In en, this message translates to:
  /// **'Earn Your First Order For Free'**
  String get eartYourFirstOrderForFree;

  /// No description provided for @burgerRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Burger Restaurants'**
  String get burgerRestaurants;

  /// No description provided for @chooseYourFavorite.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Favorite'**
  String get chooseYourFavorite;

  /// No description provided for @bestMenuOfRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Best Menu Of Restaurants'**
  String get bestMenuOfRestaurants;

  /// No description provided for @chooseYourFavoriteVendor.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Favorite Vendor'**
  String get chooseYourFavoriteVendor;

  /// No description provided for @exploreTheBestMeals.
  ///
  /// In en, this message translates to:
  /// **'Explore The Best Meals'**
  String get exploreTheBestMeals;

  /// No description provided for @earnYourFirst5OrdersForFree.
  ///
  /// In en, this message translates to:
  /// **'Earn Your First 5 Orders For Free'**
  String get earnYourFirst5OrdersForFree;

  /// No description provided for @testTest.
  ///
  /// In en, this message translates to:
  /// **'Test Test'**
  String get testTest;

  /// No description provided for @restaurants_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get restaurants_________________End;

  /// No description provided for @product_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get product_________________Start;

  /// No description provided for @selectedType.
  ///
  /// In en, this message translates to:
  /// **'Selected Type'**
  String get selectedType;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get addToCart;

  /// No description provided for @eg.
  ///
  /// In en, this message translates to:
  /// **'e.g.'**
  String get eg;

  /// No description provided for @selectType.
  ///
  /// In en, this message translates to:
  /// **'Select Type'**
  String get selectType;

  /// No description provided for @alsoOrderWith.
  ///
  /// In en, this message translates to:
  /// **'Also Order With'**
  String get alsoOrderWith;

  /// No description provided for @product_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get product_________________End;

  /// No description provided for @plans_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get plans_________________Start;

  /// No description provided for @whatIsYourPrimaryHealthFocus.
  ///
  /// In en, this message translates to:
  /// **'What Is Your Primary Health Focus'**
  String get whatIsYourPrimaryHealthFocus;

  /// No description provided for @yourPlanToOptimizeCalories.
  ///
  /// In en, this message translates to:
  /// **'Your Plan To Optimize Calories'**
  String get yourPlanToOptimizeCalories;

  /// No description provided for @weightLossPlan.
  ///
  /// In en, this message translates to:
  /// **'Weight Loss Plan'**
  String get weightLossPlan;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @gazzerVideoTutorialGuide.
  ///
  /// In en, this message translates to:
  /// **'Gazzer Video Tutorial Guide'**
  String get gazzerVideoTutorialGuide;

  /// No description provided for @gazzerVideoTutorial.
  ///
  /// In en, this message translates to:
  /// **'Gazzer Video Tutorial'**
  String get gazzerVideoTutorial;

  /// No description provided for @youMadeIt.
  ///
  /// In en, this message translates to:
  /// **'You Made It'**
  String get youMadeIt;

  /// No description provided for @plans_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get plans_________________End;

  /// No description provided for @home_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get home_________________Start;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @cuisine.
  ///
  /// In en, this message translates to:
  /// **'Cuisone'**
  String get cuisine;

  /// No description provided for @exploreCuisines.
  ///
  /// In en, this message translates to:
  /// **'explore Cuisines'**
  String get exploreCuisines;

  /// No description provided for @megaSummerSale.
  ///
  /// In en, this message translates to:
  /// **'Mega Summer\nSale'**
  String get megaSummerSale;

  /// No description provided for @freeDelivery.
  ///
  /// In en, this message translates to:
  /// **'free Delivery'**
  String get freeDelivery;

  /// No description provided for @searchForStoresItemsAndCAtegories.
  ///
  /// In en, this message translates to:
  /// **'search For Stores Items And Categories'**
  String get searchForStoresItemsAndCAtegories;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'explore'**
  String get explore;

  /// No description provided for @checkYourCart.
  ///
  /// In en, this message translates to:
  /// **'check Your Cart'**
  String get checkYourCart;

  /// No description provided for @earnYourFirst.
  ///
  /// In en, this message translates to:
  /// **'earn Your First'**
  String get earnYourFirst;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'orders'**
  String get orders;

  /// No description provided for @earnYourFirst5Orders.
  ///
  /// In en, this message translates to:
  /// **'earn Your First 5 Orders'**
  String get earnYourFirst5Orders;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'free'**
  String get free;

  /// No description provided for @topRated.
  ///
  /// In en, this message translates to:
  /// **'top Rated'**
  String get topRated;

  /// No description provided for @orderWheneverYouAre.
  ///
  /// In en, this message translates to:
  /// **'order Whenever You Are'**
  String get orderWheneverYouAre;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'contact Us'**
  String get contactUs;

  /// No description provided for @chooseYourCategories.
  ///
  /// In en, this message translates to:
  /// **'choose Your Categories'**
  String get chooseYourCategories;

  /// No description provided for @gazzerVideoTourGuide.
  ///
  /// In en, this message translates to:
  /// **'gazzer Video Tour Guide'**
  String get gazzerVideoTourGuide;

  /// No description provided for @deliverTo.
  ///
  /// In en, this message translates to:
  /// **'deliver To'**
  String get deliverTo;

  /// No description provided for @home_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get home_________________End;

  /// No description provided for @cart_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get cart_________________Start;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'TOTAL'**
  String get total;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'delivery_Fee'**
  String get deliveryFee;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'total Amount'**
  String get totalAmount;

  /// No description provided for @addItems.
  ///
  /// In en, this message translates to:
  /// **'add Items'**
  String get addItems;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'checkout'**
  String get checkout;

  /// No description provided for @shippingCart.
  ///
  /// In en, this message translates to:
  /// **'shipping Cart'**
  String get shippingCart;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'order Summary'**
  String get orderSummary;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'confirm Order'**
  String get confirmOrder;

  /// No description provided for @cart_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get cart_________________End;

  /// No description provided for @checkout_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get checkout_________________Start;

  /// No description provided for @addPRomoCode.
  ///
  /// In en, this message translates to:
  /// **'Add Promo Code'**
  String get addPRomoCode;

  /// No description provided for @addDeliveryInstruction.
  ///
  /// In en, this message translates to:
  /// **'Add Delivery Instruction'**
  String get addDeliveryInstruction;

  /// No description provided for @addTip.
  ///
  /// In en, this message translates to:
  /// **'Add Tip'**
  String get addTip;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully'**
  String get orderPlacedSuccessfully;

  /// No description provided for @checkout_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get checkout_________________End;

  /// No description provided for @core_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get core_________________Start;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @mins.
  ///
  /// In en, this message translates to:
  /// **'mins'**
  String get mins;

  /// No description provided for @secs.
  ///
  /// In en, this message translates to:
  /// **'secs'**
  String get secs;

  /// No description provided for @onAllGrills.
  ///
  /// In en, this message translates to:
  /// **'on All Grills'**
  String get onAllGrills;

  /// No description provided for @dealsStarts27May.
  ///
  /// In en, this message translates to:
  /// **'deals Starts 27 May'**
  String get dealsStarts27May;

  /// No description provided for @orderNow.
  ///
  /// In en, this message translates to:
  /// **'order Now'**
  String get orderNow;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'view All'**
  String get viewAll;

  /// No description provided for @core_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get core_________________End;

  /// No description provided for @mainScreens_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get mainScreens_________________Start;

  /// No description provided for @deliveredOn.
  ///
  /// In en, this message translates to:
  /// **'delivered On'**
  String get deliveredOn;

  /// No description provided for @recentRestaurants.
  ///
  /// In en, this message translates to:
  /// **'recent Restaurants'**
  String get recentRestaurants;

  /// No description provided for @recentGroceries.
  ///
  /// In en, this message translates to:
  /// **'recent Groceries'**
  String get recentGroceries;

  /// No description provided for @recentPharmacies.
  ///
  /// In en, this message translates to:
  /// **'recent Pharmacies'**
  String get recentPharmacies;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'recent Searches'**
  String get recentSearches;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'clear'**
  String get clear;

  /// No description provided for @gazzerApp.
  ///
  /// In en, this message translates to:
  /// **'gazzer App'**
  String get gazzerApp;

  /// No description provided for @freshFruits.
  ///
  /// In en, this message translates to:
  /// **'fresh Fruits'**
  String get freshFruits;

  /// No description provided for @dailyOffersForYou.
  ///
  /// In en, this message translates to:
  /// **'daily Offers For You'**
  String get dailyOffersForYou;

  /// No description provided for @suggestedForYou.
  ///
  /// In en, this message translates to:
  /// **'suggested For You'**
  String get suggestedForYou;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'got It'**
  String get gotIt;

  /// No description provided for @sideMenuSetting.
  ///
  /// In en, this message translates to:
  /// **'side Menu Setting'**
  String get sideMenuSetting;

  /// No description provided for @mainScreens_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get mainScreens_________________End;

  /// No description provided for @drawer_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get drawer_________________Start;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @foodPlan.
  ///
  /// In en, this message translates to:
  /// **'Food Plan'**
  String get foodPlan;

  /// No description provided for @videoTutorials.
  ///
  /// In en, this message translates to:
  /// **'Video Tutorials'**
  String get videoTutorials;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @gazzerChat.
  ///
  /// In en, this message translates to:
  /// **'Gazzer Chat'**
  String get gazzerChat;

  /// No description provided for @communityApp.
  ///
  /// In en, this message translates to:
  /// **'Community App'**
  String get communityApp;

  /// No description provided for @paymentSetting.
  ///
  /// In en, this message translates to:
  /// **'Payment Setting'**
  String get paymentSetting;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @drawer_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get drawer_________________End;

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

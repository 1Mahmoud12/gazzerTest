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

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops'**
  String get oops;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @search_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get search_________________Start;

  /// No description provided for @noResultsFoundTryAdjustingYourFilter.
  ///
  /// In en, this message translates to:
  /// **'No results found, try adjusting your filter'**
  String get noResultsFoundTryAdjustingYourFilter;

  /// No description provided for @unableToLoadResultsPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Unable to load results, please try again later'**
  String get unableToLoadResultsPleaseTryAgainLater;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort (A-Z)'**
  String get sort;

  /// No description provided for @under30mins.
  ///
  /// In en, this message translates to:
  /// **'Under 30 mins'**
  String get under30mins;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @enterTheWordYouWantToSearchFor.
  ///
  /// In en, this message translates to:
  /// **'Enter the word you want to search for'**
  String get enterTheWordYouWantToSearchFor;

  /// No description provided for @enterThreeLetterOrMore.
  ///
  /// In en, this message translates to:
  /// **'Enter three letters or more...'**
  String get enterThreeLetterOrMore;

  /// No description provided for @search_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get search_________________End;

  /// No description provided for @cart_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get cart_________________Start;

  /// No description provided for @am.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// No description provided for @noAvailableSchedulingTimeSlots.
  ///
  /// In en, this message translates to:
  /// **'No available scheduling time slots'**
  String get noAvailableSchedulingTimeSlots;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editNote;

  /// No description provided for @cartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get cartIsEmpty;

  /// No description provided for @startShopping.
  ///
  /// In en, this message translates to:
  /// **'Start Shopping'**
  String get startShopping;

  /// No description provided for @noAddressesSelected.
  ///
  /// In en, this message translates to:
  /// **'No addresses selected'**
  String get noAddressesSelected;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @selectAddress.
  ///
  /// In en, this message translates to:
  /// **'Select Address'**
  String get selectAddress;

  /// No description provided for @scheduling.
  ///
  /// In en, this message translates to:
  /// **'Scheduling'**
  String get scheduling;

  /// No description provided for @scheduleOrder.
  ///
  /// In en, this message translates to:
  /// **'Schedule Order'**
  String get scheduleOrder;

  /// No description provided for @editItemNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Item Note'**
  String get editItemNote;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @pleaseLoginToUseCart.
  ///
  /// In en, this message translates to:
  /// **'Please login to use cart'**
  String get pleaseLoginToUseCart;

  /// No description provided for @quantityValidation.
  ///
  /// In en, this message translates to:
  /// **'Quantity must be at least 1'**
  String get quantityValidation;

  /// No description provided for @yourCartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartIsEmpty;

  /// No description provided for @pleaseSelectAtLeastOneValueOptionForName.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one value option for {name}'**
  String pleaseSelectAtLeastOneValueOptionForName(String name);

  /// No description provided for @yourChoicesWillBeClearedBecauseYouDidntAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Your choices will be cleared because you didn\'t add to cart'**
  String get yourChoicesWillBeClearedBecauseYouDidntAddToCart;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get subTotal;

  /// No description provided for @serviceFee.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get serviceFee;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'MIN'**
  String get min;

  /// No description provided for @typeHere.
  ///
  /// In en, this message translates to:
  /// **'Type here'**
  String get typeHere;

  /// No description provided for @addSpecialNote.
  ///
  /// In en, this message translates to:
  /// **'Add Special Note'**
  String get addSpecialNote;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'TOTAL'**
  String get total;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @addItems.
  ///
  /// In en, this message translates to:
  /// **'Add Items'**
  String get addItems;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmOrder;

  /// No description provided for @cart_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get cart_________________End;

  /// No description provided for @address_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get address_________________Start;

  /// No description provided for @defaultAddressChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Default address changed successfully'**
  String get defaultAddressChangedSuccessfully;

  /// No description provided for @confirmDeleteAddressName.
  ///
  /// In en, this message translates to:
  /// **'Confirm delete address ({label})'**
  String confirmDeleteAddressName(String label);

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// No description provided for @pleaseSelectYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Please, select your location'**
  String get pleaseSelectYourLocation;

  /// No description provided for @saveAddress.
  ///
  /// In en, this message translates to:
  /// **'Save Address'**
  String get saveAddress;

  /// No description provided for @selectGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Select Governorate'**
  String get selectGovernorate;

  /// No description provided for @selectArea.
  ///
  /// In en, this message translates to:
  /// **'Select Area'**
  String get selectArea;

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

  /// No description provided for @addressName.
  ///
  /// In en, this message translates to:
  /// **'Address Name'**
  String get addressName;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @building.
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get building;

  /// No description provided for @buildingNameNumber.
  ///
  /// In en, this message translates to:
  /// **'Building Name/Number'**
  String get buildingNameNumber;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get apartment;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @homeAddress.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeAddress;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get floor;

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

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @landmark.
  ///
  /// In en, this message translates to:
  /// **'Landmark'**
  String get landmark;

  /// No description provided for @nearbyLandmark.
  ///
  /// In en, this message translates to:
  /// **'Nearby Landmark'**
  String get nearbyLandmark;

  /// No description provided for @province.
  ///
  /// In en, this message translates to:
  /// **'Province'**
  String get province;

  /// No description provided for @zone.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get zone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address Label'**
  String get addressLabel;

  /// No description provided for @addressLabelHint.
  ///
  /// In en, this message translates to:
  /// **'Address Label Hint'**
  String get addressLabelHint;

  /// No description provided for @address_________________Ebd.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get address_________________Ebd;

  /// No description provided for @favorite_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get favorite_________________Start;

  /// No description provided for @favoriteVendors.
  ///
  /// In en, this message translates to:
  /// **'Favorite Vendors'**
  String get favoriteVendors;

  /// No description provided for @favoriteItems.
  ///
  /// In en, this message translates to:
  /// **'Favorite Items'**
  String get favoriteItems;

  /// No description provided for @pleaseLoginToUseFavorites.
  ///
  /// In en, this message translates to:
  /// **'Please login to use favorites'**
  String get pleaseLoginToUseFavorites;

  /// No description provided for @couldnotUpdateFavorites.
  ///
  /// In en, this message translates to:
  /// **'Could not update favorites'**
  String get couldnotUpdateFavorites;

  /// No description provided for @pleaseCheckYourConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your connection'**
  String get pleaseCheckYourConnection;

  /// No description provided for @itemNameAddedToFAvorites.
  ///
  /// In en, this message translates to:
  /// **'{itemName} has been added to favorites'**
  String itemNameAddedToFAvorites(String itemName);

  /// No description provided for @itemNameRemovedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'{itemName} has been removed from favorites'**
  String itemNameRemovedFromFavorites(String itemName);

  /// No description provided for @youHaveNoFavoritesYet.
  ///
  /// In en, this message translates to:
  /// **'You have no favorites yet'**
  String get youHaveNoFavoritesYet;

  /// No description provided for @favoriteRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Favorite Restaurants'**
  String get favoriteRestaurants;

  /// No description provided for @favoriteStores.
  ///
  /// In en, this message translates to:
  /// **'Favorite Stores'**
  String get favoriteStores;

  /// No description provided for @favoritePlates.
  ///
  /// In en, this message translates to:
  /// **'Favorite Plates'**
  String get favoritePlates;

  /// No description provided for @favoriteProducts.
  ///
  /// In en, this message translates to:
  /// **'Favorite Products'**
  String get favoriteProducts;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @stores.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get stores;

  /// No description provided for @plates.
  ///
  /// In en, this message translates to:
  /// **'Plates'**
  String get plates;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @favorite_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get favorite_________________End;

  /// No description provided for @vendorCommon_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get vendorCommon_________________Start;

  /// No description provided for @soon.
  ///
  /// In en, this message translates to:
  /// **'Soon'**
  String get soon;

  /// No description provided for @nameisCurrentlyClosedWeWillOpenAt.
  ///
  /// In en, this message translates to:
  /// **'{name} is currently closed. We will open at {time}'**
  String nameisCurrentlyClosedWeWillOpenAt(String name, String time);

  /// No description provided for @thisRestaurantIsCurrentlyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This restaurant is currently unavailable'**
  String get thisRestaurantIsCurrentlyUnavailable;

  /// No description provided for @alwayeysOpen.
  ///
  /// In en, this message translates to:
  /// **'Always Open'**
  String get alwayeysOpen;

  /// No description provided for @availabilityUnknown.
  ///
  /// In en, this message translates to:
  /// **'Availability Unknown'**
  String get availabilityUnknown;

  /// No description provided for @deviceTimeIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Device time is invalid'**
  String get deviceTimeIsInvalid;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @couldnotLoadDataPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Could not load data. Please try again'**
  String get couldnotLoadDataPleaseTryAgain;

  /// No description provided for @outOFStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOFStock;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @hurryUp.
  ///
  /// In en, this message translates to:
  /// **'Hurry Up!'**
  String get hurryUp;

  /// No description provided for @vendorClosesInMinutes.
  ///
  /// In en, this message translates to:
  /// **'{vendor} closes in ({minutes})-minutes'**
  String vendorClosesInMinutes(int minutes, String vendor);

  /// No description provided for @theRestaurant.
  ///
  /// In en, this message translates to:
  /// **'The Restaurant'**
  String get theRestaurant;

  /// No description provided for @theStore.
  ///
  /// In en, this message translates to:
  /// **'The Store'**
  String get theStore;

  /// No description provided for @thePharmacy.
  ///
  /// In en, this message translates to:
  /// **'The Pharmacy'**
  String get thePharmacy;

  /// No description provided for @vendorCommon_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get vendorCommon_________________End;

  /// No description provided for @otpSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully'**
  String get otpSentSuccessfully;

  /// No description provided for @splash_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get splash_________________Start;

  /// No description provided for @errorFetchingUserData.
  ///
  /// In en, this message translates to:
  /// **'Error fetching user data'**
  String get errorFetchingUserData;

  /// No description provided for @splash_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get splash_________________End;

  /// No description provided for @profile_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get profile_________________Start;

  /// No description provided for @pleaseSelectReason.
  ///
  /// In en, this message translates to:
  /// **'Please select a reason'**
  String get pleaseSelectReason;

  /// No description provided for @accountSuccessfullyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account successfully deleted'**
  String get accountSuccessfullyDeleted;

  /// No description provided for @whyAreYouDeletingYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Why are you deleting your account?'**
  String get whyAreYouDeletingYourAccount;

  /// No description provided for @thisFeedbackHelpsUsImproveOurServices.
  ///
  /// In en, this message translates to:
  /// **'This feedback helps us improve our services.'**
  String get thisFeedbackHelpsUsImproveOurServices;

  /// No description provided for @otherReason.
  ///
  /// In en, this message translates to:
  /// **'Other Reason'**
  String get otherReason;

  /// No description provided for @confirmToDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm to delete'**
  String get confirmToDelete;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @enterReson.
  ///
  /// In en, this message translates to:
  /// **'Enter Reason'**
  String get enterReson;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated Successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @youHaveNoAddressesYet.
  ///
  /// In en, this message translates to:
  /// **'You have no addresses yet'**
  String get youHaveNoAddressesYet;

  /// No description provided for @saveEdit.
  ///
  /// In en, this message translates to:
  /// **'Save edit'**
  String get saveEdit;

  /// No description provided for @notSetYet.
  ///
  /// In en, this message translates to:
  /// **'Not set yet'**
  String get notSetYet;

  /// No description provided for @userProfile.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfile;

  /// No description provided for @goldenAccountUser.
  ///
  /// In en, this message translates to:
  /// **'Golden Account User'**
  String get goldenAccountUser;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get memberSince;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @editAccountInformation.
  ///
  /// In en, this message translates to:
  /// **'Edit Account Information'**
  String get editAccountInformation;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @addresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addresses;

  /// No description provided for @defaultt.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultt;

  /// No description provided for @setAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Set As Default'**
  String get setAsDefault;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @privacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get privacySettings;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @profile_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get profile_________________End;

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

  /// No description provided for @thisVendorIsClosedOrBusyRightNow.
  ///
  /// In en, this message translates to:
  /// **'This vendor is closed/busy right now'**
  String get thisVendorIsClosedOrBusyRightNow;

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

  /// No description provided for @youMayAlsoLike.
  ///
  /// In en, this message translates to:
  /// **'You May Also Like'**
  String get youMayAlsoLike;

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

  /// No description provided for @bestPopular.
  ///
  /// In en, this message translates to:
  /// **'Best Popular'**
  String get bestPopular;

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

  /// No description provided for @topVendors.
  ///
  /// In en, this message translates to:
  /// **'Top Vendors'**
  String get topVendors;

  /// No description provided for @megaSummerSale.
  ///
  /// In en, this message translates to:
  /// **'Mega Summer\nSale'**
  String get megaSummerSale;

  /// No description provided for @freeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Free Delivery'**
  String get freeDelivery;

  /// No description provided for @searchForStoresItemsAndCAtegories.
  ///
  /// In en, this message translates to:
  /// **'Search For Stores Items And Categories'**
  String get searchForStoresItemsAndCAtegories;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @checkYourCart.
  ///
  /// In en, this message translates to:
  /// **'Check Your Cart'**
  String get checkYourCart;

  /// No description provided for @earnYourFirst.
  ///
  /// In en, this message translates to:
  /// **'Earn Your First'**
  String get earnYourFirst;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @earnYourFirst5Orders.
  ///
  /// In en, this message translates to:
  /// **'Earn Your First 5 Orders'**
  String get earnYourFirst5Orders;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @topRated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get topRated;

  /// No description provided for @orderWheneverYouAre.
  ///
  /// In en, this message translates to:
  /// **'Order Whenever You Are'**
  String get orderWheneverYouAre;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @chooseYourCategories.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Categories'**
  String get chooseYourCategories;

  /// No description provided for @gazzerVideoTourGuide.
  ///
  /// In en, this message translates to:
  /// **'Gazzer Video Tour Guide'**
  String get gazzerVideoTourGuide;

  /// No description provided for @deliverTo.
  ///
  /// In en, this message translates to:
  /// **'Deliver To'**
  String get deliverTo;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @home_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get home_________________End;

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
  /// **'Hours'**
  String get hours;

  /// No description provided for @mins.
  ///
  /// In en, this message translates to:
  /// **'Mins'**
  String get mins;

  /// No description provided for @secs.
  ///
  /// In en, this message translates to:
  /// **'Secs'**
  String get secs;

  /// No description provided for @onAllGrills.
  ///
  /// In en, this message translates to:
  /// **'On All Grills'**
  String get onAllGrills;

  /// No description provided for @dealsStarts27May.
  ///
  /// In en, this message translates to:
  /// **'Deals Starts 27 May'**
  String get dealsStarts27May;

  /// No description provided for @orderNow.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get orderNow;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
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
  /// **'Delivered On'**
  String get deliveredOn;

  /// No description provided for @recentRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Recent Restaurants'**
  String get recentRestaurants;

  /// No description provided for @recentGroceries.
  ///
  /// In en, this message translates to:
  /// **'Recent Groceries'**
  String get recentGroceries;

  /// No description provided for @recentPharmacies.
  ///
  /// In en, this message translates to:
  /// **'Recent Pharmacies'**
  String get recentPharmacies;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get recentSearches;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @gazzerApp.
  ///
  /// In en, this message translates to:
  /// **'Gazzer App'**
  String get gazzerApp;

  /// No description provided for @freshFruits.
  ///
  /// In en, this message translates to:
  /// **'Fresh Fruits'**
  String get freshFruits;

  /// No description provided for @dailyOffersForYou.
  ///
  /// In en, this message translates to:
  /// **'Daily Offers For You'**
  String get dailyOffersForYou;

  /// No description provided for @suggestedForYou.
  ///
  /// In en, this message translates to:
  /// **'Suggested For You'**
  String get suggestedForYou;

  /// No description provided for @bestSellingItems.
  ///
  /// In en, this message translates to:
  /// **'Best Selling Items'**
  String get bestSellingItems;

  /// No description provided for @bestPopularStores.
  ///
  /// In en, this message translates to:
  /// **'Best Popular Stores'**
  String get bestPopularStores;

  /// No description provided for @noItemsAvailableInThisCategory.
  ///
  /// In en, this message translates to:
  /// **'No items available in this category'**
  String get noItemsAvailableInThisCategory;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got It'**
  String get gotIt;

  /// No description provided for @sideMenuSetting.
  ///
  /// In en, this message translates to:
  /// **'Side Menu Setting'**
  String get sideMenuSetting;

  /// No description provided for @mainScreens_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get mainScreens_________________End;

  /// No description provided for @wallet_________________Start.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get wallet_________________Start;

  /// No description provided for @walletKeepItUp.
  ///
  /// In en, this message translates to:
  /// **'Keep it up'**
  String get walletKeepItUp;

  /// No description provided for @walletNewAchievements.
  ///
  /// In en, this message translates to:
  /// **'For new achievements!'**
  String get walletNewAchievements;

  /// No description provided for @walletBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Balance : {amount} {currency}'**
  String walletBalanceLabel(String amount, String currency);

  /// No description provided for @walletAddFunds.
  ///
  /// In en, this message translates to:
  /// **'Add Funds'**
  String get walletAddFunds;

  /// No description provided for @walletRechargeViaCard.
  ///
  /// In en, this message translates to:
  /// **'Recharge Via Card'**
  String get walletRechargeViaCard;

  /// No description provided for @walletEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Amount'**
  String get walletEnterAmount;

  /// No description provided for @walletRechargeNow.
  ///
  /// In en, this message translates to:
  /// **'Recharge Now'**
  String get walletRechargeNow;

  /// No description provided for @walletConvertPointsToMoney.
  ///
  /// In en, this message translates to:
  /// **'Convert Points to Money'**
  String get walletConvertPointsToMoney;

  /// No description provided for @walletConvertLoyaltyPoints.
  ///
  /// In en, this message translates to:
  /// **'Convert Loyalty Points'**
  String get walletConvertLoyaltyPoints;

  /// No description provided for @walletConvertPointsToVoucher.
  ///
  /// In en, this message translates to:
  /// **'Convert Points to Voucher'**
  String get walletConvertPointsToVoucher;

  /// No description provided for @walletVoucherOffer.
  ///
  /// In en, this message translates to:
  /// **'{discount} EGP off Using {points} {pointsLabel}'**
  String walletVoucherOffer(int discount, int points, String pointsLabel);

  /// No description provided for @walletValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String walletValidUntil(String date);

  /// No description provided for @walletVoucherVendors.
  ///
  /// In en, this message translates to:
  /// **'Voucher Vendors'**
  String get walletVoucherVendors;

  /// No description provided for @walletVoucherAllStores.
  ///
  /// In en, this message translates to:
  /// **'All Stores'**
  String get walletVoucherAllStores;

  /// No description provided for @walletHistory.
  ///
  /// In en, this message translates to:
  /// **'Wallet History'**
  String get walletHistory;

  /// No description provided for @walletRefund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get walletRefund;

  /// No description provided for @walletRecharge.
  ///
  /// In en, this message translates to:
  /// **'Recharge'**
  String get walletRecharge;

  /// No description provided for @walletPointsConversion.
  ///
  /// In en, this message translates to:
  /// **'Points Conversion'**
  String get walletPointsConversion;

  /// No description provided for @walletCardPayment.
  ///
  /// In en, this message translates to:
  /// **'Card Payment'**
  String get walletCardPayment;

  /// No description provided for @walletOrderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order #{orderId}'**
  String walletOrderNumber(String orderId);

  /// No description provided for @walletFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get walletFilterAll;

  /// No description provided for @walletFilterAdded.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get walletFilterAdded;

  /// No description provided for @walletFilterSpent.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get walletFilterSpent;

  /// No description provided for @walletFilterFromPoints.
  ///
  /// In en, this message translates to:
  /// **'From Points'**
  String get walletFilterFromPoints;

  /// No description provided for @walletHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet History'**
  String get walletHistoryTitle;

  /// No description provided for @walletHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track all your wallet activity in one place'**
  String get walletHistorySubtitle;

  /// No description provided for @walletYouWillRecharge.
  ///
  /// In en, this message translates to:
  /// **'You will recharge {amount} {currency} to your Gazzer Wallet, Please select the payment method you want:'**
  String walletYouWillRecharge(String amount, String currency);

  /// No description provided for @walletPleaseSelectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Please select the payment method you want:'**
  String get walletPleaseSelectPaymentMethod;

  /// No description provided for @walletCreditOrDebit.
  ///
  /// In en, this message translates to:
  /// **'Credit or Debit'**
  String get walletCreditOrDebit;

  /// No description provided for @walletApplePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get walletApplePay;

  /// No description provided for @walletEWallet.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet'**
  String get walletEWallet;

  /// No description provided for @walletEnterWalletNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Wallet Number'**
  String get walletEnterWalletNumber;

  /// No description provided for @walletPayWithAnotherCard.
  ///
  /// In en, this message translates to:
  /// **'Pay with another card'**
  String get walletPayWithAnotherCard;

  /// No description provided for @walletPayNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get walletPayNow;

  /// No description provided for @wallet_________________End.
  ///
  /// In en, this message translates to:
  /// **'__________________'**
  String get wallet_________________End;

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

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

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

  /// No description provided for @loginWithPhone.
  ///
  /// In en, this message translates to:
  /// **'Login with Phone'**
  String get loginWithPhone;

  /// No description provided for @loginWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Login with Email'**
  String get loginWithEmail;

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

  /// No description provided for @callSupport.
  ///
  /// In en, this message translates to:
  /// **'Call Support'**
  String get callSupport;

  /// No description provided for @unableToMakeCall.
  ///
  /// In en, this message translates to:
  /// **'Unable to make a call. Please check your SIM card.'**
  String get unableToMakeCall;

  /// No description provided for @callFailed.
  ///
  /// In en, this message translates to:
  /// **'Call failed. Please try again or check your device settings.'**
  String get callFailed;

  /// No description provided for @callingSupport.
  ///
  /// In en, this message translates to:
  /// **'Calling support...'**
  String get callingSupport;

  /// No description provided for @deviceInAirplaneMode.
  ///
  /// In en, this message translates to:
  /// **'Your device is in airplane mode. Please disable airplane mode to make calls.'**
  String get deviceInAirplaneMode;

  /// No description provided for @noSimCardDetected.
  ///
  /// In en, this message translates to:
  /// **'No SIM card detected. Please insert a SIM card to make calls.'**
  String get noSimCardDetected;

  /// No description provided for @simCardNotReady.
  ///
  /// In en, this message translates to:
  /// **'SIM card is not ready. Please check your SIM card.'**
  String get simCardNotReady;

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
  /// **'Name accepts only characters, dashes and white spaces'**
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
  /// **'This field is required'**
  String get thisFieldIsRequired;

  /// No description provided for @fullNameShouldBeThreeLettersOrMore.
  ///
  /// In en, this message translates to:
  /// **'Full name Should be three letters or more'**
  String get fullNameShouldBeThreeLettersOrMore;

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
  /// **'{val} must be {num} characters or more'**
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

  /// No description provided for @fullEmail.
  ///
  /// In en, this message translates to:
  /// **'Full Email'**
  String get fullEmail;

  /// No description provided for @enterYourFullEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your full email'**
  String get enterYourFullEmail;

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

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStock;

  /// No description provided for @fullNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameIsRequired;

  /// No description provided for @phoneMustStartWithZero.
  ///
  /// In en, this message translates to:
  /// **'Phone number must start with 0'**
  String get phoneMustStartWithZero;

  /// No description provided for @phoneMustBeElevenDigits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be exactly 11 digits'**
  String get phoneMustBeElevenDigits;

  /// No description provided for @phoneMustBeTenDigits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be exactly 10 digits'**
  String get phoneMustBeTenDigits;

  /// No description provided for @phoneMustContainOnlyDigits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must contain only digits'**
  String get phoneMustContainOnlyDigits;

  /// No description provided for @storesOffersForYou.
  ///
  /// In en, this message translates to:
  /// **'Stores Offers For You'**
  String get storesOffersForYou;

  /// No description provided for @updating.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get updating;

  /// No description provided for @phoneMustBeTenOrElevenDigits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be 10 or 11 digits'**
  String get phoneMustBeTenOrElevenDigits;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noSearchResults;

  /// No description provided for @phoneAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This phone number is already registered'**
  String get phoneAlreadyRegistered;

  /// No description provided for @emailAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This email address is already registered'**
  String get emailAlreadyRegistered;

  /// No description provided for @phoneAndEmailAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This phone number and email are already registered'**
  String get phoneAndEmailAlreadyRegistered;

  /// No description provided for @uploadPrescription.
  ///
  /// In en, this message translates to:
  /// **'Upload Prescription'**
  String get uploadPrescription;

  /// No description provided for @pharmacyStores.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy Stores'**
  String get pharmacyStores;

  /// No description provided for @bestSellers.
  ///
  /// In en, this message translates to:
  /// **'Best Sellers'**
  String get bestSellers;

  /// No description provided for @freeDeliveryOver.
  ///
  /// In en, this message translates to:
  /// **'Free delivery on orders over 300 EG'**
  String get freeDeliveryOver;

  /// No description provided for @dailyDeal.
  ///
  /// In en, this message translates to:
  /// **'Daily Deal'**
  String get dailyDeal;

  /// No description provided for @max_quantity_reached_for_product.
  ///
  /// In en, this message translates to:
  /// **'You have reached the maximum quantity available for this product'**
  String get max_quantity_reached_for_product;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @typeYouReviewHere.
  ///
  /// In en, this message translates to:
  /// **'Type your review here'**
  String get typeYouReviewHere;

  /// No description provided for @totalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total Order'**
  String get totalOrders;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// No description provided for @noPersonalizedSuggestions.
  ///
  /// In en, this message translates to:
  /// **'No personalized suggestions yet. Start exploring our latest offers!'**
  String get noPersonalizedSuggestions;

  /// No description provided for @totalUnitSolid.
  ///
  /// In en, this message translates to:
  /// **'Total Unit Solid'**
  String get totalUnitSolid;

  /// No description provided for @updateCart.
  ///
  /// In en, this message translates to:
  /// **'Update Cart'**
  String get updateCart;

  /// No description provided for @exceedPouch.
  ///
  /// In en, this message translates to:
  /// **'Selected items exceed pouch size. Remove some items or assign additional deliveryman?'**
  String get exceedPouch;

  /// No description provided for @editItems.
  ///
  /// In en, this message translates to:
  /// **'Edit Items'**
  String get editItems;

  /// No description provided for @assignAdditionalDelivery.
  ///
  /// In en, this message translates to:
  /// **'Assign Additional Delivery'**
  String get assignAdditionalDelivery;

  /// No description provided for @cartCapacity.
  ///
  /// In en, this message translates to:
  /// **'Current Cart Capacity'**
  String get cartCapacity;

  /// No description provided for @havePromoCode.
  ///
  /// In en, this message translates to:
  /// **'Have a promo code?'**
  String get havePromoCode;

  /// No description provided for @addVoucher.
  ///
  /// In en, this message translates to:
  /// **'Add Voucher'**
  String get addVoucher;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Code'**
  String get enterCode;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @choosePaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose Payment Method'**
  String get choosePaymentMethod;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get creditCard;

  /// No description provided for @gazzarWallet.
  ///
  /// In en, this message translates to:
  /// **'Gazzar Wallet'**
  String get gazzarWallet;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @addCard.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// No description provided for @defaultCard.
  ///
  /// In en, this message translates to:
  /// **'Default Card'**
  String get defaultCard;

  /// No description provided for @availablePoints.
  ///
  /// In en, this message translates to:
  /// **'Available Points'**
  String get availablePoints;

  /// No description provided for @insufficientWalletBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient wallet balance'**
  String get insufficientWalletBalance;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @voucherApplied.
  ///
  /// In en, this message translates to:
  /// **'Voucher applied!'**
  String get voucherApplied;

  /// No description provided for @selectVoucher.
  ///
  /// In en, this message translates to:
  /// **'Select Voucher'**
  String get selectVoucher;

  /// No description provided for @pleaseEnterVoucherCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter a voucher code'**
  String get pleaseEnterVoucherCode;

  /// No description provided for @invalidVoucherCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid voucher code'**
  String get invalidVoucherCode;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get promoCode;

  /// No description provided for @createYourCard.
  ///
  /// In en, this message translates to:
  /// **'Create Your Card'**
  String get createYourCard;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @expiryMonth.
  ///
  /// In en, this message translates to:
  /// **'Expiry Month'**
  String get expiryMonth;

  /// No description provided for @expiryYear.
  ///
  /// In en, this message translates to:
  /// **'Expiry Year'**
  String get expiryYear;

  /// No description provided for @cardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get cardHolderName;

  /// No description provided for @createCard.
  ///
  /// In en, this message translates to:
  /// **'Create Card'**
  String get createCard;

  /// No description provided for @cardNumberMustBe16Digits.
  ///
  /// In en, this message translates to:
  /// **'Card number must be 16 digits'**
  String get cardNumberMustBe16Digits;

  /// No description provided for @invalidMonth.
  ///
  /// In en, this message translates to:
  /// **'Invalid month'**
  String get invalidMonth;

  /// No description provided for @invalidYear.
  ///
  /// In en, this message translates to:
  /// **'Invalid year'**
  String get invalidYear;

  /// No description provided for @expiryDateMustBeInFuture.
  ///
  /// In en, this message translates to:
  /// **'Expiry date must be in the future'**
  String get expiryDateMustBeInFuture;

  /// No description provided for @nameMustBeGreaterThanOneWord.
  ///
  /// In en, this message translates to:
  /// **'Name must be greater than one word'**
  String get nameMustBeGreaterThanOneWord;

  /// No description provided for @setAsDefaultCard.
  ///
  /// In en, this message translates to:
  /// **'Set as default card'**
  String get setAsDefaultCard;

  /// No description provided for @convert.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get convert;

  /// No description provided for @convertPoints.
  ///
  /// In en, this message translates to:
  /// **'Convert Points'**
  String get convertPoints;

  /// No description provided for @enterPoints.
  ///
  /// In en, this message translates to:
  /// **'Enter points'**
  String get enterPoints;

  /// No description provided for @invalidPoints.
  ///
  /// In en, this message translates to:
  /// **'Invalid points'**
  String get invalidPoints;

  /// No description provided for @insufficientPoints.
  ///
  /// In en, this message translates to:
  /// **'Insufficient points'**
  String get insufficientPoints;

  /// No description provided for @completePayment.
  ///
  /// In en, this message translates to:
  /// **'Complete Payment'**
  String get completePayment;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @remainingAmount.
  ///
  /// In en, this message translates to:
  /// **'Remaining Amount'**
  String get remainingAmount;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @remainingPaymentBy.
  ///
  /// In en, this message translates to:
  /// **'Remaining Payment by'**
  String get remainingPaymentBy;

  /// No description provided for @totalBeforeCode.
  ///
  /// In en, this message translates to:
  /// **'Total Before Code'**
  String get totalBeforeCode;

  /// No description provided for @vodafoneCash.
  ///
  /// In en, this message translates to:
  /// **'Vodafone Cash'**
  String get vodafoneCash;

  /// No description provided for @eCash.
  ///
  /// In en, this message translates to:
  /// **'e& Cash'**
  String get eCash;

  /// No description provided for @orangeCash.
  ///
  /// In en, this message translates to:
  /// **'Orange Cash'**
  String get orangeCash;

  /// No description provided for @payment_completed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Payment completed successfully!'**
  String get payment_completed_successfully;

  /// No description provided for @payment_failed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed. Please try again.'**
  String get payment_failed;

  /// No description provided for @order_placed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully!'**
  String get order_placed_successfully;

  /// No description provided for @startsWith01.
  ///
  /// In en, this message translates to:
  /// **'Phone number must start with 01'**
  String get startsWith01;

  /// No description provided for @swipeTwiceToExit.
  ///
  /// In en, this message translates to:
  /// **'Swipe twice to exit'**
  String get swipeTwiceToExit;

  /// No description provided for @amountToPay.
  ///
  /// In en, this message translates to:
  /// **'Amount to Pay'**
  String get amountToPay;

  /// No description provided for @continueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueShopping;

  /// No description provided for @deliveryFeeDiscount.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee Discount'**
  String get deliveryFeeDiscount;

  /// No description provided for @vatAmount.
  ///
  /// In en, this message translates to:
  /// **'VAT Amount'**
  String get vatAmount;

  /// No description provided for @itemsDiscount.
  ///
  /// In en, this message translates to:
  /// **'Items Discount'**
  String get itemsDiscount;

  /// No description provided for @grossAmount.
  ///
  /// In en, this message translates to:
  /// **'Gross Amount'**
  String get grossAmount;

  /// No description provided for @pleaseLoginToUseLoyalty.
  ///
  /// In en, this message translates to:
  /// **'please login to use loyalty program'**
  String get pleaseLoginToUseLoyalty;

  /// No description provided for @needToAddAddressFirst.
  ///
  /// In en, this message translates to:
  /// **'You need to add an address first'**
  String get needToAddAddressFirst;

  /// No description provided for @loyaltyProgram.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Program'**
  String get loyaltyProgram;

  /// No description provided for @yourLoyaltyJourney.
  ///
  /// In en, this message translates to:
  /// **'Your Loyalty Journey'**
  String get yourLoyaltyJourney;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @yourPoints.
  ///
  /// In en, this message translates to:
  /// **'Your Points'**
  String get yourPoints;

  /// No description provided for @pointsPer.
  ///
  /// In en, this message translates to:
  /// **'Points per'**
  String get pointsPer;

  /// No description provided for @earningRate.
  ///
  /// In en, this message translates to:
  /// **'Earning Rate'**
  String get earningRate;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @conversionRate.
  ///
  /// In en, this message translates to:
  /// **'Conversion Rate'**
  String get conversionRate;

  /// No description provided for @validUntill.
  ///
  /// In en, this message translates to:
  /// **'Valid Until'**
  String get validUntill;

  /// No description provided for @expiration.
  ///
  /// In en, this message translates to:
  /// **'Expiration'**
  String get expiration;

  /// No description provided for @ourTierBenefits.
  ///
  /// In en, this message translates to:
  /// **'Our Tier Benefits'**
  String get ourTierBenefits;

  /// No description provided for @birthdayVouchers.
  ///
  /// In en, this message translates to:
  /// **'Birthday Vouchers'**
  String get birthdayVouchers;

  /// No description provided for @exclusiveDeals.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Deals'**
  String get exclusiveDeals;

  /// No description provided for @exclusiveOffers.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Offers'**
  String get exclusiveOffers;

  /// No description provided for @loyaltySpendSummary.
  ///
  /// In en, this message translates to:
  /// **'You\'ve spent {amount} in the last {days} days'**
  String loyaltySpendSummary(String amount, int days);

  /// No description provided for @heroBanner.
  ///
  /// In en, this message translates to:
  /// **'You’ve reached the top — you’re one of our elite customers!'**
  String get heroBanner;

  /// No description provided for @winnerBanner.
  ///
  /// In en, this message translates to:
  /// **'You’re among our top customers, enjoy special discounts and surprises.'**
  String get winnerBanner;

  /// No description provided for @gainerBanner.
  ///
  /// In en, this message translates to:
  /// **'You’re gaining momentum! Unlock free delivery and early perks.'**
  String get gainerBanner;

  /// No description provided for @silverBanner.
  ///
  /// In en, this message translates to:
  /// **'You’re just getting started — earn points with every order!'**
  String get silverBanner;

  /// No description provided for @exclusiveVoucher.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Voucher'**
  String get exclusiveVoucher;

  /// No description provided for @exclusiveAccessLevel.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Access Level'**
  String get exclusiveAccessLevel;

  /// No description provided for @exclusiveDiscount.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Discount'**
  String get exclusiveDiscount;

  /// No description provided for @phoneMustStartWithZeroOrOne.
  ///
  /// In en, this message translates to:
  /// **'Egyptian number must start with 1 or 01'**
  String get phoneMustStartWithZeroOrOne;

  /// No description provided for @cantConvertLessZanZero.
  ///
  /// In en, this message translates to:
  /// **'You cannot convert less than zero points'**
  String get cantConvertLessZanZero;

  /// No description provided for @cantConvertMoreThanAvailable.
  ///
  /// In en, this message translates to:
  /// **'You cannot convert more points than available'**
  String get cantConvertMoreThanAvailable;

  /// No description provided for @youJustCashedIn.
  ///
  /// In en, this message translates to:
  /// **'You just cashed in'**
  String get youJustCashedIn;

  /// No description provided for @thisIsBeginning.
  ///
  /// In en, this message translates to:
  /// **'This is just the beginning,'**
  String get thisIsBeginning;

  /// No description provided for @keepCollecting.
  ///
  /// In en, this message translates to:
  /// **'This is just the beginning, keep collecting and cashing in'**
  String get keepCollecting;

  /// No description provided for @youJustCashedPoints.
  ///
  /// In en, this message translates to:
  /// **'You just cashed in {points} point for {currency} EGP'**
  String youJustCashedPoints(int points, double currency);

  /// No description provided for @nextTier.
  ///
  /// In en, this message translates to:
  /// **'Spend {currency} more to reach {name} tier'**
  String nextTier(String name, String currency);

  /// No description provided for @viewWallet.
  ///
  /// In en, this message translates to:
  /// **'View Wallet'**
  String get viewWallet;

  /// No description provided for @needToAddReviewFirst.
  ///
  /// In en, this message translates to:
  /// **'You need to add a review first'**
  String get needToAddReviewFirst;

  /// No description provided for @faqSatisfactionQuestion.
  ///
  /// In en, this message translates to:
  /// **'How satisfied are you with the FAQ answers?\nWas that helpful?'**
  String get faqSatisfactionQuestion;

  /// No description provided for @vendors.
  ///
  /// In en, this message translates to:
  /// **'Vendors'**
  String get vendors;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @viewReceipt.
  ///
  /// In en, this message translates to:
  /// **'View Receipt'**
  String get viewReceipt;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @getHelp.
  ///
  /// In en, this message translates to:
  /// **'Get Help'**
  String get getHelp;

  /// No description provided for @makeAdditonMoreThan10Pounds.
  ///
  /// In en, this message translates to:
  /// **'The added amount must be more than 10 pounds'**
  String get makeAdditonMoreThan10Pounds;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @youHaveEarnedPoints.
  ///
  /// In en, this message translates to:
  /// **'You have earned {points} points'**
  String youHaveEarnedPoints(int points);

  /// No description provided for @promoCodeName.
  ///
  /// In en, this message translates to:
  /// **'Promo Code Name'**
  String get promoCodeName;

  /// No description provided for @take.
  ///
  /// In en, this message translates to:
  /// **'Take'**
  String get take;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @addons.
  ///
  /// In en, this message translates to:
  /// **'Add-ons'**
  String get addons;

  /// No description provided for @you_rate_stars.
  ///
  /// In en, this message translates to:
  /// **'You rate {rating}/5 stars'**
  String you_rate_stars(double rating);

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// No description provided for @reOrder.
  ///
  /// In en, this message translates to:
  /// **'Re-order'**
  String get reOrder;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @cartHasExistingItems.
  ///
  /// In en, this message translates to:
  /// **'Cart Has Existing Items'**
  String get cartHasExistingItems;

  /// No description provided for @youHaveExistingItemsInCart.
  ///
  /// In en, this message translates to:
  /// **'You have {count} item(s) in your cart. Do you want to keep these items and add the reordered items to your cart, or would you prefer to clear your cart and add only the reordered items?'**
  String youHaveExistingItemsInCart(int count);

  /// No description provided for @clearAndReorder.
  ///
  /// In en, this message translates to:
  /// **'Clear and Reorder'**
  String get clearAndReorder;

  /// No description provided for @keepAndReorder.
  ///
  /// In en, this message translates to:
  /// **'Keep and Reorder'**
  String get keepAndReorder;

  /// No description provided for @deliveryMan.
  ///
  /// In en, this message translates to:
  /// **'Delivery Man'**
  String get deliveryMan;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @orderIssue.
  ///
  /// In en, this message translates to:
  /// **'Order Issue'**
  String get orderIssue;

  /// No description provided for @missingOrIncorrectItems.
  ///
  /// In en, this message translates to:
  /// **'Missing or incorrect items'**
  String get missingOrIncorrectItems;

  /// No description provided for @wholeOrderIsWrong.
  ///
  /// In en, this message translates to:
  /// **'Whole order is wrong'**
  String get wholeOrderIsWrong;

  /// No description provided for @qualityIssue.
  ///
  /// In en, this message translates to:
  /// **'Quality issue'**
  String get qualityIssue;

  /// No description provided for @issueWithDeliveryMan.
  ///
  /// In en, this message translates to:
  /// **'Issue with Delivery man'**
  String get issueWithDeliveryMan;

  /// No description provided for @paymentAndRefund.
  ///
  /// In en, this message translates to:
  /// **'Payment and refund'**
  String get paymentAndRefund;

  /// No description provided for @selectMissingIncorrectItems.
  ///
  /// In en, this message translates to:
  /// **'Please select your missing or incorrect item and we will check it :'**
  String get selectMissingIncorrectItems;

  /// No description provided for @addYourNotes.
  ///
  /// In en, this message translates to:
  /// **'Add your notes'**
  String get addYourNotes;

  /// No description provided for @typeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'type your message..'**
  String get typeYourMessage;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @weHaveChecked.
  ///
  /// In en, this message translates to:
  /// **'We have checked'**
  String get weHaveChecked;

  /// No description provided for @orderIssueOutsideRefundWindow.
  ///
  /// In en, this message translates to:
  /// **'We are sorry to hear about this issue with this order. It looks like you placed the order some time ago and it\'s now outside the eligible refund window.'**
  String get orderIssueOutsideRefundWindow;

  /// No description provided for @contactUsAsSoonAsPossible.
  ///
  /// In en, this message translates to:
  /// **'In the future, If you have an issue, Please contact us as soon as possible'**
  String get contactUsAsSoonAsPossible;

  /// No description provided for @wasThisHelpful.
  ///
  /// In en, this message translates to:
  /// **'Was this helpful?'**
  String get wasThisHelpful;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @gazzerSupport.
  ///
  /// In en, this message translates to:
  /// **'Gazzer Support'**
  String get gazzerSupport;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @guzzerSupport.
  ///
  /// In en, this message translates to:
  /// **'Guzzer Support'**
  String get guzzerSupport;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get typeMessage;

  /// No description provided for @selectImageSource.
  ///
  /// In en, this message translates to:
  /// **'Select image source'**
  String get selectImageSource;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello! How can I help you today?'**
  String get welcomeMessage;

  /// No description provided for @generalIssues.
  ///
  /// In en, this message translates to:
  /// **'General Issues'**
  String get generalIssues;

  /// No description provided for @generalIssueInquiry.
  ///
  /// In en, this message translates to:
  /// **'General Issue - Inquiry'**
  String get generalIssueInquiry;

  /// No description provided for @optionalFeedback.
  ///
  /// In en, this message translates to:
  /// **'Optional Feedback'**
  String get optionalFeedback;

  /// No description provided for @mustChooseOrderFirst.
  ///
  /// In en, this message translates to:
  /// **'You must choose an order first'**
  String get mustChooseOrderFirst;

  /// No description provided for @youMustCheckOneAtLeast.
  ///
  /// In en, this message translates to:
  /// **'You must select at least one option'**
  String get youMustCheckOneAtLeast;
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

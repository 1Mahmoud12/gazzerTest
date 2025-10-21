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
  /// **'This field is required.'**
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

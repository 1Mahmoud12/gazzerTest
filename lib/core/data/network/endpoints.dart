class Endpoints {
  // general
  static const String onboarding = 'onboarding';
  static const String setting = 'settings';
  static const String recommendedProds = '/recommended-products';

  // category & product
  static const String categories = 'categories';
  static String singleCategoryProds(String slug) => 'category/$slug';
  static const String home = 'home-categories';
  static const String advertisements = 'advertisements';
  static const String banner = 'banner';
  static const String categoriesWzProducts = 'categories/withProducts';
  static String productById(String slug) => 'product/$slug';
  static const String checkProducts = 'checkProducts';
  static const String wordSearch = 'words-search';
  static const String prodSearch = 'search';

  // auth
  static const String login = 'user/login';
  static const String sendOtp = 'user/send-otp';
  static const String logout = 'user/logout';

//  ** user related **
  static const String profile = 'user';
  static const String editProfile = 'user/edit-profile';
  static const String deleteAccount = 'user/delete-account';

  //user orders
  static String allOrdersPage(int i) => 'orders?page=$i';
  static String orderDetails(String uuid) => 'orders/$uuid';
  static String cancelOrder(String uuid) => 'orders/cancel/$uuid';
  static String reviewOrderItem(String uuid) => 'orders/review/$uuid';

  /// notifications
  static String notifications(int page) => 'notifications?page=$page';

  // user address
  static const String addAddress = 'address';
  static String addressById(int id) => 'address/$id';
  static String setDefaultAddress(int id) => 'address/default/$id';
  static const String countries = 'active-countries';
  static String countryStates(int id) => 'country/$id/states';

// checkout
  static const String checkout = 'orders';
  static const String checkCoupon = 'coupons/check';

  //singles
  static const String contactUs = "contact-us";

  // join as doctor
  static const String doctorRequest = 'doctor-request';
  static const String requestStatus = 'doctor-request/status';
  static const String specialities = 'specializations';

  // doctors data
  static const String doctors = 'doctors';
  static String doctorDetails(int id) => 'doctors/$id';

  // ** doctor related **
}

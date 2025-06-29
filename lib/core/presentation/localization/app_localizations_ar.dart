// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get requestTimeOut => 'انتهت مهلة الطلب';

  @override
  String get weakOrNoInternetConnection =>
      'اتصال ضعيف أو لا يوجد اتصال بالإنترنت';

  @override
  String get requestToServerWasCancelled => 'تم إلغاء الطلب إلى الخادم';

  @override
  String get unknownErorOccurred => 'حدث خطأ غير معروف';

  @override
  String get clickBackAgainToExit => 'اضغط مرة أخرى للخروج';

  @override
  String get thisFieldIsRequired => 'هذا الحقل مطلوب.';

  @override
  String get passwordLengthError => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل.';

  @override
  String get invalidEmail => 'يرجى إدخال عنوان بريد إلكتروني صالح.';

  @override
  String valueMustBeNum(int num, String val) {
    return 'قيمة $val يجب أن تكون  $num ارقام';
  }

  @override
  String get invalidPhoneNumber => 'يرجى إدخال رقم هاتف صالح.';

  @override
  String get next => 'التالي';

  @override
  String get start => 'ابدأ';

  @override
  String get hiIamGazzer => 'مرحباً، أنا جازر';

  @override
  String get welcome => 'مرحباً';

  @override
  String get niceToMeetYou => 'تشرفنا بلقائك';

  @override
  String get letsGo => 'هيا بنا';

  @override
  String get selectMode => 'اختر الوضع';

  @override
  String get guestMode => 'وضع الضيف';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get or => 'أو';

  @override
  String get singUpToExploreWideVarietyOfProducts =>
      'سجل لاستكشاف مجموعة واسعة من المنتجات';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get yourFullName => 'اسمك الكامل';

  @override
  String get mobileNumber => 'رقم الهاتف المحمول';

  @override
  String get yourMobileNumber => 'رقم هاتفك المحمول';

  @override
  String get continu => 'متابعة';

  @override
  String get setYourLocation => 'حدد موقعك';

  @override
  String get healthyPlan => 'خطة صحية';

  @override
  String get thisPartHelpYouToBeMoreHealthy =>
      'هذا الجزء يساعدك لتكون أكثر صحة';

  @override
  String get setHealthPlan => 'تحديد الخطة الصحية';

  @override
  String get skip => 'تخطي';

  @override
  String get loading => 'جاري التحميل';

  @override
  String get congratulations => 'تهانينا';

  @override
  String get youMadeIt => 'لقد نجحت';

  @override
  String get chooseYourMood => 'اختر مزاجك';

  @override
  String get happy => 'سعيد';

  @override
  String get sad => 'حزين';

  @override
  String get angry => 'غاضب';

  @override
  String get excited => 'متحمس';

  @override
  String get bored => 'ممل';
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_state.dart';
import 'package:gazzer/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit() : super(AppSettingsState(lang: di<SharedPreferences>().getString(StorageKeys.locale)));

  void changeLanguage(String lang) {
    if (lang == state.lang) return;
    di<SharedPreferences>().setString(StorageKeys.locale, lang);
    di<ApiClient>().changeLocale(lang);
    emit(AppSettingsState(lang: lang));
  }

  @override
  void emit(AppSettingsState state) {
    if (isClosed) return;
    super.emit(state);
  }
}

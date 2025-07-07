class AppSettingsState {
  final String? lang;

  const AppSettingsState({required this.lang});

  AppSettingsState copyWith({String? lang}) {
    return AppSettingsState(lang: lang ?? this.lang);
  }
}

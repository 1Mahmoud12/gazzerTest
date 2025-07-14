class AppSettingsState {
  final String lang;
  final bool isDarkMode;

  const AppSettingsState({required this.lang, required this.isDarkMode});

  AppSettingsState copyWith({String? lang, bool? isDarkMode}) {
    return AppSettingsState(
      lang: lang ?? this.lang,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

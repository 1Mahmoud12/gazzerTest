import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:go_router/go_router.dart';

class LanguageItem {
  const LanguageItem({required this.code, required this.name, required this.flagAsset});

  final String code;
  final String name;
  final String flagAsset;
}

class LanguageCustomDropdown extends StatelessWidget {
  const LanguageCustomDropdown({super.key, required this.startPadding});

  final double startPadding;

  static const List<LanguageItem> languages = [
    LanguageItem(code: 'en', name: 'English', flagAsset: Assets.assetsPngFlagEn),
    LanguageItem(code: 'ar', name: 'العربية', flagAsset: Assets.assetsPngFlagEg),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppSettingsCubit>();
    final currentLang = cubit.state.lang;
    final selectedLanguage = languages.firstWhere((lang) => lang.code == currentLang, orElse: () => languages.first);

    return CustomDropdown<LanguageItem>(
      items: languages,
      selectedItem: selectedLanguage,
      width: MediaQuery.sizeOf(context).width * .6,
      onChanged: (language) async {
        if (language.code != currentLang) {
          await cubit.changeLanguage(language.code);
          //di<HomeCubit>().getHomeData();
          if (context.mounted) {
            // Navigate to profile screen - it will automatically load profile data
            context.go('/');
          }
        }
      },

      itemBuilder: (context, language) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Image.asset(language.flagAsset, height: 24, width: 24),
              const HorizontalSpacing(8),
              Text(language.name, style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
            ],
          ),
        );
      },
      selectedItemBuilder: (context, language) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(language.flagAsset, height: 24, width: 24),
            const HorizontalSpacing(8),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(language.name, style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
              ),
            ),
          ],
        );
      },
    );
  }
}

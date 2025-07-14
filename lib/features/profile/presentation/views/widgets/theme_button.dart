part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class ThemeBtn extends StatelessWidget {
  const ThemeBtn({super.key, required this.startPadding});
  final double startPadding;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HorizontalSpacing(startPadding),
        Text(L10n.tr().darkMode, style: TStyle.secondarySemi(14)),
        const Spacer(),
        Theme(
          data: Theme.of(context).copyWith(
            switchTheme: SwitchThemeData(
              thumbColor: const WidgetStateColor.fromMap({WidgetState.selected: Co.secondary, WidgetState.any: Co.lightGrey}),
              trackColor: WidgetStateColor.fromMap(
                {WidgetState.selected: Co.purple, WidgetState.any: Co.grey.withAlpha(150)},
              ),
            ),
          ),
          child: Switch(
            value: context.read<AppSettingsCubit>().state.isDarkMode,
            onChanged: (v) {
              context.read<AppSettingsCubit>().toggleDarkMode();
            },
          ).withScale(scale: 0.8, alignment: Alignment.centerRight),
        ),
      ],
    );
  }
}

part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class ThemeBtn extends StatelessWidget {
  const ThemeBtn({super.key, required this.startPadding});
  final double startPadding;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppSettingsCubit>();
    final isDarkMode = cubit.state.isDarkMode;

    return InkWell(
      onTap: () {
        cubit.toggleDarkMode();
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Co.purple),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(isDarkMode ? Assets.darkIc : Assets.lightIc, height: 24, width: 24),
            const HorizontalSpacing(8),
            Text(
              isDarkMode ? L10n.tr().dark : L10n.tr().light,
              style: TStyle.robotBlackRegular14().copyWith(color: Co.white, fontWeight: TStyle.medium),
            ),
          ],
        ),
      ),
    );
  }
}

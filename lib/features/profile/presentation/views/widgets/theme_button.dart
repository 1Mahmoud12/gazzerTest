part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class ThemeBtn extends StatelessWidget {
  const ThemeBtn({super.key, required this.startPadding});
  final double startPadding;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppSettingsCubit>();

    return InkWell(
      onTap: () {
        cubit.toggleDarkMode();
      },
      borderRadius: BorderRadius.circular(24),
      child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, state) {
          final isDarkMode = state.isDarkMode;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Co.purple,
            ),
            child: AnimatedSwitcher(
              duration: Durations.extralong4,
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.9, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Row(
                key: ValueKey(isDarkMode),
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    isDarkMode ? Assets.darkIc : Assets.lightIc,
                    height: 24,
                    width: 24,
                  ),
                  const HorizontalSpacing(8),
                  Text(
                    isDarkMode ? L10n.tr().dark : L10n.tr().light,
                    style: context.style14400.copyWith(
                      color: Co.white,
                      fontWeight: TStyle.medium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

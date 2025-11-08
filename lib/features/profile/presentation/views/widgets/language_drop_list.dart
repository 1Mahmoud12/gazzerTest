import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/profile/presentation/views/profile_screen.dart';
import 'package:go_router/go_router.dart';

class LanguageDropList extends StatelessWidget {
  const LanguageDropList({super.key, required this.startPadding});
  final double startPadding;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppSettingsCubit>();
    return Row(
      children: [
        HorizontalSpacing(startPadding),
        Expanded(
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: AppConst.defaultBorderRadius,
                borderSide: const BorderSide(color: Co.purple, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppConst.defaultBorderRadius,
                borderSide: const BorderSide(color: Co.purple, width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: AppConst.defaultBorderRadius,
                borderSide: const BorderSide(color: Co.purple, width: 1),
              ),
            ),
            focusColor: Co.purple,
            style: TStyle.primarySemi(14),
            borderRadius: AppConst.defaultBorderRadius,
            isExpanded: true,
            iconEnabledColor: Co.purple,
            value: cubit.state.lang,

            items: [
              const DropdownMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              const DropdownMenuItem(
                value: 'ar',
                child: Text('العربية'),
              ),
            ],
            onChanged: (value) async {
              if (value != null) await cubit.changeLanguage(value);
              di<HomeCubit>().getHomeData();
              if (context.mounted) {
                context.push(HomeScreen.route);
                context.push(ProfileScreen.route);
              }
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/working_hours_cubit.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/working_hours_states.dart';

import '../../../../../core/presentation/extensions/context.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkingHoursCubit(di.get())..loadWorkingHours(),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacityNew(0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(Assets.assetsSvgCharacter, fit: BoxFit.contain),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(L10n.tr().guzzerSupport, style: context.style16400.copyWith(fontWeight: TStyle.bold)),
                  const SizedBox(height: 2),
                  BlocBuilder<WorkingHoursCubit, WorkingHoursState>(
                    builder: (context, state) {
                      bool isOnline = false;

                      if (state is WorkingHoursLoaded) {
                        isOnline = context.read<WorkingHoursCubit>().isCurrentlyOnline(state.workingHours);
                      }

                      return Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(color: isOnline ? Colors.green : Colors.grey, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isOnline ? L10n.tr().online : L10n.tr().offline,
                            style: context.style16500.copyWith(color: isOnline ? Colors.green : Colors.grey),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

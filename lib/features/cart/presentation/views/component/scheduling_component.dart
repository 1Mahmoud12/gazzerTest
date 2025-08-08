import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/main_switcher.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SchedulingComponent extends StatefulWidget {
  const SchedulingComponent({super.key});

  @override
  State<SchedulingComponent> createState() => _SchedulingComponentState();
}

class _SchedulingComponentState extends State<SchedulingComponent> {
  bool switchToggled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 8,
                children: [
                  Text(
                    L10n.tr().scheduling,
                    style: TStyle.primaryBold(16),
                  ),
                  BlocBuilder<CartCubit, CartStates>(
                    buildWhen: (previous, current) => current is TimeSlotsStates,
                    builder: (context, state) => AnimatedOpacity(
                      opacity: state is TimeSlotsStates && state.selectedTime != null ? 1 : 0,
                      duration: Durations.medium1,
                      child: Text(
                        ' (${state is! TimeSlotsStates ? '' : Helpers.formatTimeSlot(state.selectedTime ?? '')})',
                        style: TStyle.greySemi(14),
                      ),
                    ),
                  ),
                ],
              ),
              Switch(
                value: switchToggled,
                onChanged: (v) {
                  if (v) {
                    context.read<CartCubit>().getTimeSlots();
                  } else {
                    context.read<CartCubit>().selectTimeSlot(null);
                  }
                  setState(() => switchToggled = v);
                },
              ).withScale(scale: 0.8),
            ],
          ),
          if (switchToggled) ...[
            const Divider(height: 25, thickness: 1),
            SizedBox(
              height: 40,
              child: BlocBuilder<CartCubit, CartStates>(
                buildWhen: (previous, current) => current is TimeSlotsStates,
                builder: (context, state) {
                  if (state is! TimeSlotsStates) return const SizedBox.shrink();
                  if (state is TimeSlotsLoaded && state.timeSlots.isEmpty) {
                    return Center(
                      child: Text(L10n.tr().noAvailableSchedulingTimeSlots, style: TStyle.greyBold(14)),
                    );
                  }
                  return Skeletonizer(
                    enabled: state is TimeSlotsLoading,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.timeSlots.length,
                      separatorBuilder: (context, index) => const HorizontalSpacing(8),
                      itemBuilder: (context, index) {
                        return OutlinedButton(
                          onPressed: () {
                            context.read<CartCubit>().selectTimeSlot(state.timeSlots[index]);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: state.selectedTime == state.timeSlots[index]
                                ? Co.purple.withAlpha(70)
                                : Colors.transparent,
                            minimumSize: Size.zero,
                            side: const BorderSide(color: Co.purple),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            Helpers.formatTimeSlot(state.timeSlots[index]),
                            style: TStyle.primaryBold(14),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

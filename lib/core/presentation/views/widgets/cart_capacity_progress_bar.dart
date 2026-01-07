import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';

/// A progress bar widget that displays cart capacity fill percentage
/// with dynamic color based on fill level:
/// - Green: Less than 60%
/// - Orange: From 60% to 85%
/// - Red: From 85% to 100%
class CartCapacityProgressBar extends StatelessWidget {
  const CartCapacityProgressBar({super.key, this.height = 4.0, this.borderRadius});

  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      buildWhen: (previous, current) {
        // Only rebuild when cart is loaded and pouch summary changes
        if (current is FullCartLoaded && previous is FullCartLoaded) {
          return previous.pouchSummary?.totalFillPercentage != current.pouchSummary?.totalFillPercentage;
        }
        return current is FullCartLoaded;
      },
      builder: (context, state) {
        if (state is! FullCartLoaded || state.pouchSummary == null) {
          return const SizedBox.shrink();
        }

        final pouchSummary = state.pouchSummary!;
        final totalCapacity = pouchSummary.totalCapacity?.toDouble() ?? 0.0;
        final totalLoad = pouchSummary.totalLoad?.toDouble() ?? 0.0;

        // Calculate fill percentage
        double fillPercentage = 0.0;
        if (totalCapacity > 0) {
          fillPercentage = (totalLoad / totalCapacity) * 100;
        }

        // Clamp to 0-100
        fillPercentage = fillPercentage.clamp(0.0, 100.0);

        // Determine color based on fill percentage
        Color progressColor;
        if (fillPercentage < 60) {
          progressColor = Colors.green;
        } else if (fillPercentage < 85) {
          progressColor = Co.secondary; // Orange
        } else {
          progressColor = Co.red;
        }

        return InkWell(
          onTap: () {
            Alerts.showToast(L10n.tr().cartCapacity, error: false, isInfo: true);
          },
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
            child: LinearProgressIndicator(
              value: fillPercentage / 100,
              minHeight: height,
              backgroundColor: Colors.grey.withOpacityNew(0.5),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}

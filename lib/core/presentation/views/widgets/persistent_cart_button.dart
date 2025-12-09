import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';
import 'package:go_router/go_router.dart';

class PersistentCartButton extends StatelessWidget {
  const PersistentCartButton({super.key});

  void _navigateToCart(BuildContext context) {
    SystemSound.play(SystemSoundType.click);
    context.go(CartScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToCart(context),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Co.purple.withOpacityNew(0.25), blurRadius: 15, spreadRadius: 2, offset: const Offset(0, 4))],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Progress ring
            BlocBuilder<CartCubit, CartStates>(
              buildWhen: (previous, current) {
                if (current is FullCartLoaded && previous is FullCartLoaded) {
                  return previous.pouchSummary?.totalFillPercentage != current.pouchSummary?.totalFillPercentage;
                }
                return current is FullCartLoaded;
              },
              builder: (context, state) {
                double fillPercentage = 0.0;
                Color progressColor = Colors.green;

                if (state is FullCartLoaded && state.pouchSummary != null) {
                  final pouchSummary = state.pouchSummary!;
                  final totalCapacity = pouchSummary.totalCapacity?.toDouble() ?? 0.0;
                  final totalLoad = pouchSummary.totalLoad?.toDouble() ?? 0.0;

                  if (totalCapacity > 0) {
                    fillPercentage = (totalLoad / totalCapacity) * 100;
                    fillPercentage = fillPercentage.clamp(0.0, 100.0);
                  }

                  if (fillPercentage < 60) {
                    progressColor = Colors.green;
                  } else if (fillPercentage < 85) {
                    progressColor = Co.secondary;
                  } else {
                    progressColor = Co.red;
                  }
                }
                return SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    value: fillPercentage / 100,
                    backgroundColor: Colors.grey.withOpacityNew(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    strokeWidth: 4.0,
                  ),
                );
              },
            ),
            // Cart icon
            Container(
              width: 55,
              height: 55,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Center(
                child: SvgPicture.asset(Assets.cartIc, height: 28, width: 28, colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

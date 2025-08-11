import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_events.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoriteWidget<T> extends StatefulWidget {
  /// [fovorable] can be either a [GenericVendorEntity] (restaurant / store) or [GenericItemEntity] (plate / product/ ordered with)
  const FavoriteWidget({super.key, this.size = 32, this.padding = 8, required this.fovorable, this.color});
  final Favorable fovorable;
  final double size;
  final double padding;
  final Color? color;
  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late bool isFav;

  late StreamSubscription<ToggleFavoriteStates> lisnter;
  late final FavoriteBus bus;

  _listen(ToggleFavoriteStates v) {
    if (!mounted) return;
    if (v.id != widget.fovorable.id || v.type != widget.fovorable.favoriteType.toView) return;
    if (v is AddedFavoriteSuccess || v is RemovedFavoriteSuccess) {
      _pulseAnmateFav();
      if (v is AddedFavoriteSuccess) {
        Alerts.showToast(L10n.tr().itemNameAddedToFAvorites(widget.fovorable.name), error: false);
      } else {
        Alerts.showToast(L10n.tr().itemNameRemovedFromFavorites(widget.fovorable.name), error: false);
      }
    } else if (v is ToggleFavoriteFailure) {
      Alerts.showToast("${L10n.tr().couldnotUpdateFavorites}. ${L10n.tr().pleaseCheckYourConnection}");
    }
  }

  @override
  void initState() {
    bus = di<FavoriteBus>();
    isFav = bus.isFavorite(widget.fovorable);
    controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: 1, end: 1.25).animate(controller);
    super.initState();
    lisnter = bus.subscribe<ToggleFavoriteStates>(_listen);
  }

  @override
  void dispose() {
    lisnter.cancel();
    controller.dispose();
    super.dispose();
  }

  Future<void> _pulseAnmateFav() async {
    controller.forward().then((_) async {
      if (!mounted) return;
      setState(() {
        isFav = !isFav;
      });
      controller.reverse();
      controller.forward();
      controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bus.getStream<ToggleFavoriteStates>(),
      builder: (context, snapshot) {
        if (snapshot.data is ToggleFavoriteLoading && snapshot.data!.id == widget.fovorable.id && snapshot.data!.type == widget.fovorable.favoriteType.toView) {
          return Padding(
            padding: EdgeInsets.all(widget.padding),
            child: AdaptiveProgressIndicator(size: widget.size, color: widget.color),
          );
        }
        return IconButton(
          onPressed: () async {
            SystemSound.play(SystemSoundType.click);
            if (Session().client == null) {
              Alerts.showToast(L10n.tr().pleaseLoginToUseFavorites);
              context.push(LoginScreen.route);
              return;
            }
            await bus.toggleFavorite(widget.fovorable);
          },
          style: IconButton.styleFrom(
            padding: EdgeInsets.all(widget.padding),
            shape: const CircleBorder(),
            minimumSize: Size.zero,
            iconSize: widget.size,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.center,
          ),
          icon: ScaleTransition(
            scale: animation,
            child: Icon(isFav ? Icons.favorite : Icons.favorite_border_rounded, color: Co.secondary, size: widget.size),
          ),
        );
      },
    );
  }
}

///
///
///
class DecoratedFavoriteWidget extends StatelessWidget {
  const DecoratedFavoriteWidget({
    super.key,
    this.size = 32,
    this.padding = 8,
    this.isDarkContainer = true,
    this.borderRadius,
    required this.fovorable,
  });
  final double size;
  final double padding;
  final bool isDarkContainer;
  final BorderRadiusGeometry? borderRadius;
  final Favorable fovorable;

  @override
  Widget build(BuildContext context) {
    if (isDarkContainer) {
      return Skeleton.shade(
        child: DoubledDecoratedWidget(
          innerDecoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadiusGeometry.circular(12),
            gradient: Grad().linearGradient,
          ),
          child: FavoriteWidget(
            key: ValueKey(fovorable.id),
            size: size,
            padding: padding,
            fovorable: fovorable,
            color: Co.bg,
          ),
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        border: GradientBoxBorder(gradient: Grad().shadowGrad()),
        borderRadius: borderRadius ?? BorderRadiusGeometry.circular(12),
        gradient: Grad().bgLinear.copyWith(
          stops: const [0.0, 1],
          colors: [const Color(0x55402788), Colors.transparent],
        ),
      ),
      child: FavoriteWidget(key: ValueKey(fovorable.id), size: size, padding: padding, fovorable: fovorable),
    );
  }
}

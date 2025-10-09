import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart' show AppConst;
import 'package:gazzer/core/presentation/theme/app_theme.dart' show TStyle, Co;
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/utils/product_shape_painter.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/decoration_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show VerticalSpacing, AdaptiveProgressIndicator;
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/smart_cart_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_events.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({super.key, required this.favorite, required this.onTap});
  final Favorable favorite;
  final Function() onTap;

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  late StreamSubscription<ToggleFavoriteStates> lisnter;
  late final FavoriteBus bus;

  @override
  void initState() {
    bus = di<FavoriteBus>();

    lisnter = bus.subscribe<ToggleFavoriteStates>((v) {
      if (!mounted) return;
      if (v.id != widget.favorite.id || v.type != widget.favorite.favoriteType) return;
      if (v is RemovedFavoriteSuccess) {
        Alerts.showToast(
          L10n.tr().itemNameRemovedFromFavorites(widget.favorite.name),
          error: false,
        );
      } else if (v is ToggleFavoriteFailure) {
        Alerts.showToast(
          "${L10n.tr().couldnotUpdateFavorites}. ${L10n.tr().pleaseCheckYourConnection}",
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    bus.unSubscribe<ToggleFavoriteStates>(lisnter);
    super.dispose();
  }

  /// Helper method to get CartItemType from favorite type string
  CartItemType? _getCartItemType() {
    final type = widget.favorite.favoriteType.type;
    if (type == CartItemType.plate.value) return CartItemType.plate;
    if (type == CartItemType.product.value) return CartItemType.product;
    if (type == CartItemType.restaurantItem.value) return CartItemType.restaurantItem;
    return null;
  }

  /// Check if favorite can be added to cart
  bool _canAddToCart() {
    return Session().client != null && _getCartItemType() != null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: InkWell(
        borderRadius: AppConst.defaultBorderRadius,
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: Session().client != null ? 175 : 150,
                width: double.infinity,
                child: CustomPaint(
                  painter: ProductShapePaint(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 58, 4, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          spacing: 6,
                          children: [
                            SizedBox(
                              height: 30,
                              child: CircleGradientBorderedImage(
                                image: widget.favorite.image,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                Helpers.shortIrretableStrings(
                                      widget.favorite.name.split(' '),
                                      24,
                                    ) ??
                                    '',
                                style: TStyle.primaryBold(12),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpacing(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.favorite.favorablePrice != null)
                              Text(
                                Helpers.getProperPrice(
                                  widget.favorite.favorablePrice!,
                                ),
                                style: TStyle.tertiaryBold(12),
                              )
                            else
                              const SizedBox.shrink(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Co.secondary,
                                  size: 16,
                                ),
                                Text(
                                  widget.favorite.rate.toStringAsFixed(1),
                                  style: TStyle.secondarySemi(12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            widget.favorite.description,
                            style: TStyle.blackSemi(12),
                          ),
                        ),
                        const VerticalSpacing(8),
                        if (_canAddToCart())
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: SmartCartWidget(
                              id: widget.favorite.id,
                              type: _getCartItemType()!,
                              outOfStock: widget.favorite.outOfStock,
                              cartBus: di<CartBus>(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Transform.rotate(
                angle: -0.25,
                child: ClipRRect(
                  borderRadius: AppConst.defaultBorderRadius,
                  child: CustomNetworkImage(
                    widget.favorite.image,
                    fit: BoxFit.cover,
                    width: 95,
                    height: 50,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 60,
              right: 0,
              child: DoubledDecoratedWidget(
                child: StreamBuilder(
                  stream: bus.getStream<ToggleFavoriteStates>(),
                  builder: (context, snapshot) {
                    if (snapshot.data is ToggleFavoriteLoading &&
                        snapshot.data!.id == widget.favorite.id &&
                        snapshot.data!.type == widget.favorite.favoriteType.toView) {
                      return const Padding(
                        padding: EdgeInsets.all(6),
                        child: AdaptiveProgressIndicator(
                          size: 20,
                          color: Co.bg,
                        ),
                      );
                    }
                    return IconButton(
                      onPressed: () {
                        di<FavoriteBus>().toggleFavorite(widget.favorite);
                      },
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(6),
                        shape: const CircleBorder(),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: const Icon(
                        CupertinoIcons.delete,
                        color: Co.secondary,
                        size: 18,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

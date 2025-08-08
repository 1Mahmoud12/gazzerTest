import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/views/select_address_screen.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/cart_address_widget.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';
import 'package:go_router/go_router.dart';

class CartAddressComponent extends StatelessWidget {
  const CartAddressComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L10n.tr().deliveryAddress,
            style: TStyle.primaryBold(16),
          ),
          const Divider(height: 9, thickness: 1),
          BlocBuilder<CartCubit, CartStates>(
            buildWhen: (previous, current) => current is UpdateCartAddress,
            builder: (context, state) {
              if (state is! UpdateCartAddress || state.address == null) {
                return SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: Co.secondary,
                        child: SvgPicture.asset(
                          Assets.assetsSvgHomeOutlined,
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            L10n.tr().noAddressesSelected,
                            style: TStyle.greyBold(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is UpdateCartAddressLoading) {
                return const Center(child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: AdaptiveProgressIndicator(),
                ));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CartAddressWidget(address: AddressModel.fromEntity(state.address!)),
              );
            },
          ),

          MainBtn(
            onPressed: () {
              context.push<AddressEntity>(SelectAddressScreen.route).then((address) {
                if (address != null && context.mounted) context.read<CartCubit>().updateCartAddress(address);
              });
            },
            bgColor: Co.secondary,
            text: L10n.tr().selectAddress,
            radius: 12,
            textStyle: TStyle.primaryBold(14),
          ),
        ],
      ),
    );
  }
}

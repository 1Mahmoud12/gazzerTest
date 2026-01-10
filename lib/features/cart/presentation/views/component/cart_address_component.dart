import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/views/select_address_screen.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';
import 'package:gazzer/features/profile/presentation/views/widgets/address_card.dart';
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
          Text(L10n.tr().deliveryAddress, style: context.style16400.copyWith(color: Co.purple)),
          const Divider(height: 9, thickness: 1),
          BlocBuilder<CartCubit, CartStates>(
            buildWhen: (previous, current) => current is FullCartStates,
            builder: (context, state) {
              if (state is! FullCartStates || state.address == null) {
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
                          child: Text(L10n.tr().noAddressesSelected, style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey)),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is FullCartLoading) {
                return const Center(
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 12), child: AdaptiveProgressIndicator()),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AddressCard(address: AddressModel.fromEntity(state.address!), defaultButton: false),
              );
            },
          ),

          MainBtn(
            onPressed: () {
              context.push<AddressEntity>(SelectAddressScreen.route).then((address) {
                if (address != null && context.mounted) context.read<CartCubit>().updateCartAddress(address);
              });
            },
            text: L10n.tr().selectAnotherAddress,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/checkout/presentation/cubit/cardsCubit/cards_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';

class SavedCardsScreen extends StatefulWidget {
  const SavedCardsScreen({super.key});

  static const route = '/saved-cards';

  @override
  State<SavedCardsScreen> createState() => _SavedCardsScreenState();
}

class _SavedCardsScreenState extends State<SavedCardsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Session().client != null && mounted) {
        context.read<CheckoutCubit>().loadCheckoutData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CheckoutCubit>(),
      child: Scaffold(
        appBar: MainAppBar(title: L10n.tr().saved_cards, iconsColor: Co.secondary),
        body: Session().client == null
            ? UnAuthComponent(msg: L10n.tr().please_login_to_view_saved_cards)
            : BlocBuilder<CheckoutCubit, CheckoutStates>(
                buildWhen: (previous, current) => current is CheckoutDataLoading || current is CheckoutDataLoaded || current is CardsLoaded,
                builder: (context, state) {
                  final cubit = context.read<CheckoutCubit>();
                  final cards = cubit.cards;

                  if (state is CheckoutDataLoading) {
                    return const Center(child: AdaptiveProgressIndicator());
                  }

                  return RefreshIndicator(
                    onRefresh: () => cubit.loadCheckoutData(),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                      children: [
                        if (cards.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.credit_card_off, size: 64, color: Co.grey),
                                  const VerticalSpacing(16),
                                  Text(L10n.tr().no_saved_cards, style: TStyle.greyRegular(16), textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                          )
                        else
                          ...cards.map((card) => _CardItem(card: card)),
                        const VerticalSpacing(24),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

enum CardBrand { masterCard, visa }

class _CardItem extends StatelessWidget {
  const _CardItem({required this.card});

  final CardEntity card;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Co.bg,
        border: Border.all(color: card.isDefault ? Co.purple : Colors.transparent, width: 2),
      ),
      child: Row(
        children: [
          VectorGraphicsWidget(
            card.cardBrand == CardBrand.masterCard ? Assets.masterCardIc : Assets.visaCardIc,
            width: MediaQuery.sizeOf(context).width * .4,
          ),
          const HorizontalSpacing(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(card.cardHolderName, style: TStyle.robotBlackMedium()),
                ),
                const VerticalSpacing(10),
                Text(card.maskedCardNumber, style: TStyle.robotBlackRegular()),
                const VerticalSpacing(10),
                Text(card.formattedExpiry, style: TStyle.robotBlackRegular()),
                if (card.isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Co.purple.withOpacityNew(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Text(L10n.tr().defaultCard, style: TStyle.primaryBold(10)),
                  ),
                const HorizontalSpacing(8),
                InkWell(
                  onTap: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return Dialogs.confirmDialog(
                          title: L10n.tr().warning,
                          message: L10n.tr().areYouSureYouWantToDeleteThisItem,
                          okBgColor: Co.red,
                          context: context,
                        );
                      },
                    );
                    if (confirmed == true) {
                      final cardsCubit = di<CardsCubit>();
                      await cardsCubit.deleteCard(card.id);
                      // Reload checkout data to refresh the cards list
                      if (context.mounted) {
                        context.read<CheckoutCubit>().loadCheckoutData();
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const VectorGraphicsWidget(Assets.deleteIc),
                      const HorizontalSpacing(6),
                      Text(L10n.tr().delete, style: TStyle.robotBlackRegular()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

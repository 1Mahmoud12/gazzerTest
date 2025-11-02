import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkout_states.dart';

class VoucherWidget extends StatefulWidget {
  const VoucherWidget({
    super.key,
  });

  @override
  State<VoucherWidget> createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  late final TextEditingController _voucherController;

  @override
  void initState() {
    super.initState();
    _voucherController = TextEditingController();
  }

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Co.buttonGradient.withOpacityNew(.35)),
      ),
      child: Column(
        children: [
          BlocBuilder<CheckoutCubit, CheckoutStates>(
            builder: (context, state) {
              final cubit = context.read<CheckoutCubit>();

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        L10n.tr().havePromoCode,
                        style: TStyle.blackBold(14),
                      ),
                      InkWell(
                        onTap: () {
                          cubit.toggleTextField();
                        },
                        child: Text(
                          L10n.tr().addVoucher,
                          style: TStyle.blackBold(14),
                        ),
                      ),
                    ],
                  ),
                  if (!cubit.isTextFieldEnabled) ...[
                    const VerticalSpacing(10),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: AppConst.defaultBorderRadius,
                          borderSide: const BorderSide(
                            color: Co.purple,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: AppConst.defaultBorderRadius,
                          borderSide: const BorderSide(
                            color: Co.purple,
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: AppConst.defaultBorderRadius,
                          borderSide: const BorderSide(
                            color: Co.purple,
                            width: 1,
                          ),
                        ),
                      ),
                      focusColor: Co.purple,
                      style: TStyle.primarySemi(14),
                      borderRadius: AppConst.defaultBorderRadius,
                      isExpanded: true,
                      iconEnabledColor: Co.purple,
                      hint: const Text('Select Voucher'),
                      items: cubit.vouchers.map((voucher) {
                        return DropdownMenuItem(
                          value: voucher,
                          child: Text(voucher),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          _voucherController.text = value;
                          // cubit.toggleTextField();
                        }
                      },
                    ),
                  ] else ...[
                    const VerticalSpacing(10),
                    Row(
                      children: [
                        Expanded(
                          child: MainTextField(
                            controller: _voucherController,
                            showBorder: true,
                            borderRadius: 16,
                            hintText: L10n.tr().enterCode,
                            validator: Validators.notEmpty,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const HorizontalSpacing(10),
                        Expanded(
                          child: BlocConsumer<CheckoutCubit, CheckoutStates>(
                            listener: (context, state) {
                              if (state is VoucherApplied) {
                                Alerts.showToast(
                                  'Voucher applied! ${state.discountAmount}% discount',
                                  error: false,
                                );
                              } else if (state is VoucherError) {
                                Alerts.showToast(state.message);
                              }
                            },
                            builder: (context, state) {
                              final isLoading = state is VoucherLoading;
                              return MainBtn(
                                onPressed: () {
                                  if (_voucherController.text.trim().isNotEmpty) {
                                    cubit.applyVoucher(
                                      _voucherController.text,
                                    );
                                  }
                                },
                                isLoading: isLoading,
                                text: L10n.tr().apply,
                                bgColor: Co.secondary,
                                textStyle: TStyle.burbleBold(14),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

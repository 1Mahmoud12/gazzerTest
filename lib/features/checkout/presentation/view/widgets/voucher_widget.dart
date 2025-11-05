import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/voucherCubit/vouchers_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/voucherCubit/vouchers_states.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/voucher_alert_widget.dart';

class VoucherWidget extends StatefulWidget {
  const VoucherWidget({super.key});

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
          BlocBuilder<VouchersCubit, VouchersStates>(
            builder: (context, state) {
              final cubit = context.read<VouchersCubit>();

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => cubit.loadVouchers(),
                        child: Text(
                          L10n.tr().havePromoCode,
                          style: TStyle.blackBold(14),
                        ),
                      ),
                      InkWell(
                        onTap: cubit.toggleTextField,
                        child: Text(
                          L10n.tr().addVoucher,
                          style: TStyle.blackBold(14),
                        ),
                      ),
                    ],
                  ),
                  if (!cubit.isTextFieldEnabled) ...[
                    const VerticalSpacing(10),
                    BlocListener<VouchersCubit, VouchersStates>(
                      listener: (context, state) {
                        if (state is VoucherApplied) {
                          voucherAlert(
                            title:
                                '${L10n.tr().voucherApplied} ${state.discountAmount} ${state.discountType.contains('percent') ? '%' : ''} ${L10n.tr().discount}',
                            context: context,
                            asDialog: true,
                          );
                        } else if (state is VoucherError) {
                          voucherAlert(title: state.message, context: context);
                        }
                      },
                      child: DropdownButtonFormField<String>(
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
                        hint: Text(L10n.tr().selectVoucher),
                        items: cubit.vouchers.map((code) {
                          return DropdownMenuItem(
                            value: code,
                            child: Text(code),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            _voucherController.text = value;
                            cubit.applyLocalVoucher(value);
                            context.read<CheckoutCubit>().applyVoucher(value);
                          }
                        },
                      ),
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
                            onChange: (value) => setState(() {}),
                          ),
                        ),
                        const HorizontalSpacing(10),
                        Expanded(
                          child: BlocConsumer<VouchersCubit, VouchersStates>(
                            listener: (context, state) {
                              if (state is VoucherApplied) {
                                voucherAlert(
                                  title: '${L10n.tr().voucherApplied} ${state.discountAmount}% ${L10n.tr().discount}',
                                  context: context,
                                  asDialog: true,
                                );
                                context.read<CheckoutCubit>().applyVoucher(state.voucherCode);
                              } else if (state is VoucherError) {
                                voucherAlert(
                                  title: state.message,
                                  context: context,
                                );
                              }
                            },
                            builder: (context, state) {
                              final isLoading = state is VoucherLoading;
                              return MainBtn(
                                onPressed: () {
                                  if (_voucherController.text.trim().isNotEmpty) {
                                    cubit.applyVoucher(_voucherController.text);
                                  }
                                },
                                isLoading: isLoading,
                                text: L10n.tr().apply,
                                bgColor: _voucherController.text.trim().isEmpty ? Co.grey : Co.secondary,
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

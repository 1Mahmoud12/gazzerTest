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
import 'package:gazzer/features/checkout/data/dtos/checkout_data_dto.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';
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
    // Load vouchers after the first frame to avoid build errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<VouchersCubit>().loadVouchers();
      }
    });
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
                      // InkWell(
                      //   onTap: () {
                      //     _voucherController.clear();
                      //     cubit.toggleTextField();
                      //   },
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         L10n.tr().addVoucher,
                      //         style: TStyle.blackBold(14),
                      //       ),
                      //       const SizedBox(
                      //         width: 3,
                      //       ),
                      //       const Icon(
                      //         Icons.add,
                      //         size: 16,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  if (!cubit.isTextFieldEnabled) ...[
                    const VerticalSpacing(10),
                    BlocBuilder<CheckoutCubit, CheckoutStates>(
                      builder: (context, state) {
                        final checkoutCubit = context.read<CheckoutCubit>();
                        final appliedVoucher = checkoutCubit.voucherCode;
                        final hasVoucher = appliedVoucher != null && appliedVoucher.isNotEmpty;

                        return Row(
                          children: [
                            BlocListener<VouchersCubit, VouchersStates>(
                              listener: (context, state) {
                                if (state is VoucherApplied) {
                                  Alerts.showToast(
                                    '${L10n.tr().voucherApplied} ${state.discountAmount} ${state.discountType.contains('percent') ? '%' : ''} ${L10n.tr().discount}',
                                    error: false,
                                  );
                                } else if (state is VoucherError) {
                                  voucherAlert(
                                    title: state.message,
                                    context: context,
                                  );
                                }
                              },
                              child: Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: hasVoucher ? appliedVoucher : cubit.selectedVoucherCode,
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
                                  items: cubit.vouchers.map((
                                    VoucherDTO voucher,
                                  ) {
                                    return DropdownMenuItem(
                                      value: voucher.code,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(voucher.code),
                                          if (cubit.selectedVoucherCode != voucher.code)
                                            Text(
                                              '${voucher.discountValue} ${voucher.discountType.contains('percent') ? '%' : L10n.tr().egp}',
                                            ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      _voucherController.text = value;
                                      cubit.applyLocalVoucher(value);
                                      checkoutCubit.applyVoucher(value);
                                    }
                                  },
                                ),
                              ),
                            ),
                            if (hasVoucher) ...[
                              const HorizontalSpacing(8),
                              InkWell(
                                onTap: () {
                                  _voucherController.clear();
                                  checkoutCubit.applyVoucher(null);
                                  cubit.clearVoucher();
                                },
                                child: const Icon(
                                  Icons.delete,
                                  size: 24,
                                  color: Co.red,
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ] else ...[
                    const VerticalSpacing(10),
                    BlocBuilder<CheckoutCubit, CheckoutStates>(
                      builder: (context, state) {
                        final checkoutCubit = context.read<CheckoutCubit>();
                        final appliedVoucher = checkoutCubit.voucherCode;
                        final hasVoucher = appliedVoucher != null && appliedVoucher.isNotEmpty;
                        final formKey = GlobalKey<FormState>();
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Form(
                                key: formKey,
                                child: MainTextField(
                                  controller: _voucherController,
                                  showBorder: true,
                                  borderRadius: 16,
                                  hintText: L10n.tr().enterCode,
                                  validator: Validators.notEmpty,
                                  keyboardType: TextInputType.text,

                                  onChange: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            const HorizontalSpacing(10),
                            Expanded(
                              child: BlocConsumer<VouchersCubit, VouchersStates>(
                                listener: (context, state) {
                                  if (state is VoucherApplied) {
                                    Alerts.showToast(
                                      '${L10n.tr().voucherApplied} ${state.discountAmount}% ${L10n.tr().discount}',
                                      error: false,
                                    );

                                    checkoutCubit.applyVoucher(
                                      state.voucherCode,
                                    );
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
                                      if (formKey.currentState!.validate()) {
                                        return;
                                      }
                                      if (_voucherController.text.trim().isNotEmpty) {
                                        cubit.applyVoucher(
                                          _voucherController.text,
                                        );
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
                            if (hasVoucher) ...[
                              const HorizontalSpacing(8),
                              InkWell(
                                onTap: () {
                                  _voucherController.clear();
                                  checkoutCubit.applyVoucher(null);
                                  cubit.clearVoucher();
                                },
                                child: const Icon(
                                  Icons.delete,
                                  size: 24,
                                  color: Co.red,
                                ),
                              ),
                            ],
                          ],
                        );
                      },
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

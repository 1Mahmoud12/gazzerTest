import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/input_borders/gradient_outline_input_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:intl_phone_number_field/models/country_code_model.dart';
import 'package:intl_phone_number_field/models/country_config.dart';
import 'package:intl_phone_number_field/models/dialog_config.dart';
import 'package:intl_phone_number_field/models/phone_config.dart';
import 'package:intl_phone_number_field/util/general_util.dart';
import 'package:intl_phone_number_field/view/flag_view.dart';

class InternationalPhoneNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final double? height;
  final bool inactive;
  final DialogConfig dialogConfig;
  final CountryConfig countryConfig;
  final PhoneConfig phoneConfig;
  final CountryCodeModel initCountry;
  final dynamic Function(IntPhoneNumber number)? onInputChanged;
  final double betweenPadding;
  final MaskedInputFormatter? formatter;
  final List<TextInputFormatter> inputFormatters;
  final Future<String?> Function()? loadFromJson;
  final String? Function(String? number)? validator;
  final bool showBorder;
  InternationalPhoneNumberInput({
    super.key,
    TextEditingController? controller,
    this.height = 60,
    this.inputFormatters = const [],
    CountryCodeModel? initCountry,
    this.betweenPadding = 23,
    this.onInputChanged,
    this.loadFromJson,
    this.formatter,
    this.validator,
    this.inactive = false,
    DialogConfig? dialogConfig,
    CountryConfig? countryConfig,
    PhoneConfig? phoneConfig,
    required this.showBorder,
  }) : dialogConfig = dialogConfig ?? DialogConfig(),
       controller = controller ?? TextEditingController(),
       countryConfig = countryConfig ?? CountryConfig(),
       initCountry = initCountry ?? CountryCodeModel(name: "United States", dial_code: "+1", code: "US"),
       phoneConfig = phoneConfig ?? PhoneConfig();

  @override
  State<InternationalPhoneNumberInput> createState() => _InternationalPhoneNumberInputState();
}

class _InternationalPhoneNumberInputState extends State<InternationalPhoneNumberInput> {
  List<CountryCodeModel>? countries;
  late CountryCodeModel selected;

  // String? errorText;
  late FocusNode node;

  @override
  void initState() {
    selected = widget.initCountry;
    if (widget.loadFromJson == null) {
      getAllCountry();
    } else {
      widget.loadFromJson!().then((data) => data != null ? loadFromJson(data) : getAllCountry());
    }
    node = widget.phoneConfig.focusNode ?? FocusNode();
    widget.controller.addListener(controllerOnChange);
    super.initState();
  }

  void controllerOnChange() {
    if (widget.onInputChanged != null) {
      widget.onInputChanged!(IntPhoneNumber(code: selected.code, dialCode: selected.dial_code, number: widget.controller.text.trimLeft().trimRight()));
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(controllerOnChange);
    // node.removeListener(listenNode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: InkWell(
            borderRadius: AppConst.defaultBorderRadius,
            // onTap: () {
            //   if (!widget.inactive && countries != null) {
            //     SystemSound.play(SystemSoundType.click);
            //     showModalBottomSheet(
            //       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            //       barrierColor: Colors.black38,
            //       isScrollControlled: true,
            //       backgroundColor: widget.dialogConfig.backgroundColor,
            //       context: context,
            //       builder: (context) {
            //         return SingleChildScrollView(
            //           child: CountryCodeBottomSheet(
            //             countries: countries!,
            //             selected: selected,
            //             onSelected: (countryCodeModel) {
            //               setState(() {
            //                 selected = countryCodeModel;
            //               });
            //               if (widget.onInputChanged != null) {
            //                 widget.onInputChanged!(
            //                   IntPhoneNumber(code: selected.code, dialCode: selected.dial_code, number: widget.controller.text.trimLeft().trimRight()),
            //                 );
            //               }
            //             },
            //             dialogConfig: widget.dialogConfig,
            //           ),
            //         );
            //       },
            //     );
            //   }
            // },
            // style: TextButton.styleFrom(
            //   minimumSize: Size.zero,
            //   padding: EdgeInsets.zero,
            //   maximumSize: Size.zero,
            //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // ),
            child: DecoratedBox(
              decoration: widget.countryConfig.decoration,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 5,
                    children: [
                      FlagView(countryCodeModel: selected, isFlat: widget.countryConfig.flatFlag, size: 24),
                      Text(selected.dial_code, style: widget.phoneConfig.hintStyle),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: widget.betweenPadding),
        Expanded(
          flex: 18,
          child: TextFormField(
            controller: widget.controller,
            maxLines: 1,
            minLines: 1,
            // expands: expands,
            autofocus: widget.phoneConfig.autoFocus,
            showCursor: widget.phoneConfig.showCursor,

            textInputAction: widget.phoneConfig.textInputAction,
            focusNode: widget.phoneConfig.focusNode,
            style: widget.phoneConfig.textStyle.copyWith(decoration: TextDecoration.none),
            scrollPadding: EdgeInsets.zero,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            autocorrect: false,
            autofillHints: const [AutofillHints.telephoneNumber],
            enableSuggestions: false,
            validator: widget.validator,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              filled: widget.phoneConfig.backgroundColor != null,
              fillColor: widget.phoneConfig.backgroundColor,
              hintStyle: widget.phoneConfig.hintStyle,
              hintText: widget.phoneConfig.hintText,
              border: !widget.showBorder ? null : GradientOutlineInputBorder(gradient: Grad().errorGradient, width: 2),
              enabledBorder: !widget.showBorder
                  ? OutlineInputBorder(borderSide: BorderSide.none, borderRadius: AppConst.defaultBorderRadius)
                  : GradientOutlineInputBorder(gradient: Grad().shadowGrad(), width: 2, borderRadius: AppConst.defaultInnerBorderRadius),
              focusedBorder: !widget.showBorder
                  ? OutlineInputBorder(borderSide: BorderSide.none, borderRadius: AppConst.defaultBorderRadius)
                  : GradientOutlineInputBorder(gradient: Grad().shadowGrad(), width: 2, borderRadius: AppConst.defaultInnerBorderRadius),

              focusedErrorBorder: !widget.showBorder
                  ? OutlineInputBorder(borderSide: BorderSide.none, borderRadius: AppConst.defaultBorderRadius)
                  : GradientOutlineInputBorder(gradient: Grad().errorGradient, width: 1, borderRadius: AppConst.defaultBorderRadius),
              errorBorder: !widget.showBorder
                  ? OutlineInputBorder(borderSide: BorderSide.none, borderRadius: AppConst.defaultBorderRadius)
                  : GradientOutlineInputBorder(gradient: Grad().errorGradient, width: 1, borderRadius: AppConst.defaultBorderRadius),
              labelText: widget.phoneConfig.labelText,
              labelStyle: widget.phoneConfig.labelStyle,
              errorMaxLines: 4,
              errorText: widget.phoneConfig.errorText,
              errorStyle: widget.phoneConfig.errorStyle,
              floatingLabelStyle: widget.phoneConfig.floatingLabelStyle,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getAllCountry() async {
    if (widget.loadFromJson != null) {
    } else {
      countries = await GeneralUtil.loadJson();
    }
    setState(() {});
  }

  void loadFromJson(String data) {
    Iterable jsonResult = json.decode(data);
    countries = List<CountryCodeModel>.from(
      jsonResult.map((model) {
        try {
          return CountryCodeModel.fromJson(model);
        } catch (e, stackTrace) {
          log("Json Converter Failed: ", error: e, stackTrace: stackTrace);
        }
      }),
    );
    setState(() {});
  }
}

class IntPhoneNumber {
  String code, dialCode, number;
  IntPhoneNumber({required this.code, required this.dialCode, required this.number});
  String get fullNumber => "$dialCode $number";
  String get rawNumber => number.replaceAll(" ", "");
  String get rawDialCode => dialCode.replaceAll("+", "");
  String get rawFullNumber => fullNumber.replaceAll(" ", "").replaceAll("+", "");
}

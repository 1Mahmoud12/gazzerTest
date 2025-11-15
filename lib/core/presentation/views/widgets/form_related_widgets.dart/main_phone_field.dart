import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/pkgs/intl_phone/intl_phone.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:intl_phone_number_field/models/country_code_model.dart';
import 'package:intl_phone_number_field/models/country_config.dart';
import 'package:intl_phone_number_field/models/dialog_config.dart';
import 'package:intl_phone_number_field/models/phone_config.dart';
import 'package:intl_phone_number_field/util/country_list.dart';

class PhoneTextField extends StatefulWidget {
  // final String? Function(String?)? validator;
  final Function(IntPhoneNumber)? onChange;
  final String? Function(String? v, String code)? validator;
  final TextEditingController? controller;
  final String? phoneNumb;
  final String? code;
  final bool noInitcode;
  final Color? bgColor;
  final double? height;
  final bool hasLabel;
  final bool hasHint;
  final bool showBorder;
  final Color? borderColor;
  final EdgeInsets? padding;

  const PhoneTextField({
    super.key,
    required this.validator,
    this.controller,
    this.onChange,
    this.padding,
    this.phoneNumb,
    this.code,
    this.noInitcode = false,
    this.bgColor,
    this.borderColor,
    this.height,
    this.showBorder = true,
    this.hasLabel = true,
    this.hasHint = false,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  String? countryCode;
  CountryCodeModel? country;
  late final TextEditingController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();
    if (widget.phoneNumb != null) {
      _controller.text = widget.phoneNumb!;
    }
    final countries = GeneralUtil.loadJson();
    countryCode = widget.code ?? 'EG';
    country = countries.firstWhereOrNull((e) => e.code == countryCode);
    super.initState();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  String _normalizeEgyptNumber(String number) {
    var normalized = number;
    if (normalized.length >= 3 && normalized.startsWith('001')) {
      normalized = '01${normalized.substring(3)}';
    }
    if (normalized.startsWith('0') && !normalized.startsWith('01')) {
      while (normalized.length > 1 && normalized.startsWith('0') && normalized[1] != '1') {
        normalized = normalized.substring(1);
      }
    }
    return normalized;
  }

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      height: (widget.height ?? 60),
      controller: _controller,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      initCountry: country,
      betweenPadding: 10,
      showBorder: widget.showBorder,

      onInputChanged: (phone) {
        if (!mounted) {
          return;
        }
        setState(() => countryCode = phone.code);
        if (phone.code == 'EG') {
          final normalized = _normalizeEgyptNumber(phone.number);
          if (normalized != phone.number) {
            _controller.value = TextEditingValue(
              text: normalized,
              selection: TextSelection.collapsed(offset: normalized.length),
            );
            return;
          }
        }
        if (widget.onChange == null) return;
        if (phone.number.trim().isNotEmpty) {
          widget.onChange!(phone);
        }
      },
      // loadFromJson: loadFromJson,
      dialogConfig: DialogConfig(
        backgroundColor: widget.bgColor ?? const Color(0xFFffffff),
        searchBoxBackgroundColor: Co.grey.withAlpha(20),
        searchBoxIconColor: const Color(0xFF444448),
        countryItemHeight: 55,
        topBarColor: Colors.black45,
        selectedItemColor: Co.purple.withAlpha(20),
        // selectedIcon:
        //     Icon(Icons.check_box, color: Co.mainOrange, size: 15.r),
        textStyle: TStyle.greyRegular(14),
        searchBoxTextStyle: TStyle.greyRegular(14),
        titleStyle: TStyle.greyBold(14),
        searchBoxHintStyle: TStyle.greyRegular(14),
      ),
      countryConfig: CountryConfig(
        flagSize: 30,
        decoration: BoxDecoration(
          color: widget.bgColor,
          border: !widget.showBorder ? null : GradientBoxBorder(gradient: Grad().shadowGrad(), width: 2),
          borderRadius: AppConst.defaultBorderRadius,
        ),
        textStyle: TStyle.greyRegular(14),
      ),
      validator: (v) {
        final currentCode = countryCode ?? 'SA';
        if (currentCode == 'EG') {
          final value = (v ?? '').trim();
          if (value.isNotEmpty && !(value.startsWith('1') || value.startsWith('01'))) {
            return L10n.tr(context).phoneMustStartWithZeroOrOne;
          }
        }
        if (widget.validator != null) {
          return widget.validator!(v, currentCode);
        }
        return null;
      },

      phoneConfig: PhoneConfig(
        focusedColor: widget.borderColor ?? Colors.black54,
        enabledColor: widget.borderColor ?? Colors.black54,
        errorColor: const Color(0xFFFF5494),
        labelStyle: TStyle.greyRegular(14),
        labelText: widget.hasLabel ? "Phone Number" : null,
        floatingLabelStyle: TStyle.greyRegular(14),
        focusNode: null,
        radius: 16,
        hintText: !widget.hasHint
            ? null
            : countryCode == 'EG'
            ? '1xxxxxxxxx'
            : 'xxxxxx',
        borderWidth: 2,
        backgroundColor: widget.bgColor,
        decoration: null,
        popUpErrorText: true,
        autoFocus: false,
        showCursor: true,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        errorTextMaxLength: 2,
        errorPadding: const EdgeInsets.only(top: 14),
        errorStyle: TStyle.errorSemi(13),
        textStyle: TStyle.greySemi(14),
        hintStyle: TStyle.greySemi(14),
      ),
    );
  }
}

class GeneralUtil {
  static List<CountryCodeModel> loadJson() {
    List<CountryCodeModel> listCountryCodeModel = List<CountryCodeModel>.from(
      countries.map((model) => CountryCodeModel.fromJson(model)),
    );

    return listCountryCodeModel;
  }
}

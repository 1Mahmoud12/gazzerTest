import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart'
    show MainTextField, PhoneTextField;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:gazzer/features/auth/register/presentation/view/create_password_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String countryCode = "EG";
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ClassicAppBar(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Co.purple.withAlpha(50), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: AppConst.defaultHrPadding,
            children: [
              Center(child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
              Row(
                children: [
                  GradientText(text: L10n.tr().signUp, style: TStyle.mainwBold(32), gradient: Grad.textGradient),
                ],
              ),
              const VerticalSpacing(8),
              Text(L10n.tr().singUpToExploreWideVarietyOfProducts, maxLines: 2, style: TStyle.greySemi(16)),
              const VerticalSpacing(24),
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(L10n.tr().fullName, style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    MainTextField(
                      controller: _nameController,
                      hintText: L10n.tr().yourFullName,
                      bgColor: Colors.transparent,
                      validator: (v) {
                        return Validators.dashedCharactersOnly(v) ??
                            Validators.valueAtLeastNum(v, L10n.tr().fullName, 3);
                      },
                      autofillHints: [AutofillHints.username, AutofillHints.name],
                    ),
                    const VerticalSpacing(24),
                    Text(L10n.tr().mobileNumber, style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    PhoneTextField(
                      controller: _phoneController,
                      hasLabel: false,
                      hasHint: true,
                      code: countryCode,
                      validator: (v, code) {
                        countryCode = code;
                        if (code == 'EG') {
                          return Validators.mobileEGValidator(v);
                        }
                        return Validators.valueAtLeastNum(v, L10n.tr().mobileNumber, 6);
                      },
                    ),
                  ],
                ),
              ),
              const VerticalSpacing(24),
              const VerticalSpacing(24),
              Hero(
                tag: Tags.btn,
                child: OptionBtn(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      TextInput.finishAutofillContext();
                      context.myPush(
                        BlocProvider(
                          create: (context) => di<RegisterCubit>(),
                          child: CreatePasswordScreen(
                            req: RegisterRequest(
                              name: _nameController.text,
                              countryIso: countryCode,
                              phone: _phoneController.text,
                              password: '',
                              passwordConfirmation: '',
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  textStyle: TStyle.mainwSemi(15),
                  bgColor: Colors.transparent,
                  child: GradientText(text: L10n.tr().continu, style: TStyle.blackSemi(16)),
                ),
              ),
              // const VerticalSpacing(24),
              // Center(child: Text(L10n.tr().or, style: TStyle.greyRegular(16))),
              // const VerticalSpacing(10),
              // const SocialAuthWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

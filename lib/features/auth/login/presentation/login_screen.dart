import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart' show PhoneTextField, MainTextField;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/forgot_password/presentation/forgot_password_btn.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_states.dart';
import 'package:gazzer/features/auth/register/presentation/view/register_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const route = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _pasword = TextEditingController();

  final social = [Assets.assetsSvgFacebook, Assets.assetsSvgGoogle, Assets.assetsSvgApple];

  @override
  void dispose() {
    _pasword.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<LoginCubit>(),
      child: Builder(
        builder: (context) {
          return ImageBackgroundWidget(
            image: Assets.assetsPngLoginShape,
            child: Scaffold(
              backgroundColor: Colors.transparent,
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
                          GradientText(
                            text: L10n.tr().login,
                            style: TStyle.mainwBold(32),
                            gradient: Grad().textGradient,
                          ),
                        ],
                      ),
                      const VerticalSpacing(16),
                      AutofillGroup(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(L10n.tr().mobileNumber, maxLines: 1, style: TStyle.greySemi(16)),
                            const VerticalSpacing(8),
                            PhoneTextField(
                              hasLabel: false,
                              hasHint: true,
                              controller: _phoneController,
                              validator: (v, code) {
                                if (code == 'EG') {
                                  return Validators.mobileEGValidator(v);
                                }
                                return Validators.valueAtLeastNum(v, L10n.tr().mobileNumber, 6);
                              },
                            ),
                            const VerticalSpacing(16),
                            Text(L10n.tr().password, maxLines: 1, style: TStyle.greySemi(16)),
                            const VerticalSpacing(8),
                            MainTextField(
                              controller: _pasword,
                              hintText: L10n.tr().enterYourPassword,
                              bgColor: Colors.transparent,
                              isPassword: true,
                              borderRadius: 32,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                              validator: Validators.notEmpty,
                              autofillHints: [AutofillHints.newPassword],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [ForgetPasswordBtn()],
                            ),
                          ],
                        ),
                      ),

                      // const VerticalSpacing(8),
                      BlocConsumer<LoginCubit, LoginStates>(
                        listener: (context, state) {
                          if (state is LoginSuccessState) {
                            Alerts.showToast(state.message, error: false);
                            const LoadingScreenRoute(navigateToRoute: HomeScreen.route).go(context);
                          } else if (state is LoginErrorState) {
                            Alerts.showToast(state.error);
                          }
                        },
                        builder: (context, state) => Hero(
                          tag: Tags.btn,
                          child: OptionBtn(
                            isLoading: state is LoginLoadingState,
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                TextInput.finishAutofillContext();
                                context.read<LoginCubit>().login(_phoneController.text.trim(), _pasword.text.trim());
                              }
                            },
                            textStyle: TStyle.mainwSemi(15),
                            bgColor: Colors.transparent,
                            child: GradientText(text: L10n.tr().login, style: TStyle.blackSemi(16)),
                          ),
                        ),
                      ),
                      const VerticalSpacing(16),
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: OptionBtn(
                              onPressed: () {
                                if (Navigator.canPop(context)) return context.pop();
                                const LoadingScreenRoute(navigateToRoute: HomeScreen.route).go(context);
                              },
                              textStyle: TStyle.mainwSemi(15),
                              bgColor: Colors.transparent,
                              child: Text(L10n.tr().skip, style: TStyle.primarySemi(16)),
                            ),
                          ),
                          Expanded(
                            child: OptionBtn(
                              onPressed: () {
                                context.push(RegisterScreen.route);
                              },
                              textStyle: TStyle.mainwSemi(15),
                              bgColor: Colors.transparent,
                              child: Text(L10n.tr().signUp, style: TStyle.primarySemi(16)),
                            ),
                          ),
                        ],
                      ),
                      // const VerticalSpacing(8),
                      // Center(child: Text(L10n.tr().or, style: TStyle.greyRegular(16))),
                      // const VerticalSpacing(8),
                      // const SocialAuthWidget(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

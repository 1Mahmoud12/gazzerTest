import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_states.dart';
import 'package:gazzer/features/auth/verify/presentation/verify_otp_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/main.dart';
import 'package:go_router/go_router.dart';

part 'create_password_screen.g.dart';

@TypedGoRoute<CreatePasswordRoute>(path: CreatePasswordScreen.routeWithExtra)
@immutable
class CreatePasswordRoute extends GoRouteData with _$CreatePasswordRoute {
  const CreatePasswordRoute({required this.$extra});
  final RegisterRequest $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreatePasswordScreen(req: $extra);
  }
}

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key, required this.req});
  static const routeWithExtra = '/create-password';
  final RegisterRequest req;
  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  late RegisterRequest req;

  @override
  void initState() {
    req = widget.req;
    super.initState();
  }

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<RegisterCubit>(),

      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const ClassicAppBar(),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: AppConst.defaultHrPadding,
                children: [
                  Center(child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
                  Text(
                    L10n.tr().createPassword,
                    style: context.style32700.copyWith(color: Co.purple),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    L10n.tr().createPasswordToVerify,
                    style: context.style14400.copyWith(color: Co.gr100),
                    textAlign: TextAlign.center,
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Directionality(
                  //       textDirection: TextDirection.ltr,
                  //       child: Text('(+20)-${req.phone}', style: context.style14400.copyWith(color: Co.darkGrey,fontWeight:TStyle.medium)),
                  //     ),
                  //     TextButton(
                  //       onPressed: () async {
                  //         await showModalBottomSheet(
                  //           context: context,
                  //           isScrollControlled: true,
                  //           backgroundColor: Colors.transparent,
                  //           builder: (context) {
                  //             return ChangePhoneNumberSheet(
                  //               initialPhone: widget.req.phone,
                  //               onConfirm: (val) async {
                  //                 req = req.copyWith(phone: val);
                  //                 return true;
                  //               },
                  //             );
                  //           },
                  //         );
                  //         setState(() {});
                  //       },
                  //       child: Text(L10n.tr().wrongNumber, style: context.style14400.copyWith(color: Co.purple)),
                  //     ),
                  //   ],
                  // ),
                  const VerticalSpacing(32),
                  AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(L10n.tr().password, maxLines: 1, style: context.style14400),
                        const VerticalSpacing(8),
                        Directionality(
                          textDirection: TextDirection.ltr,

                          child: MainTextField(
                            prefix: SvgPicture.asset(Assets.lockIc),

                            controller: password,
                            hintText: L10n.tr().yourNewPassword,
                            bgColor: Colors.transparent,
                            isPassword: true,
                            validator: Validators.passwordValidation,
                            autofillHints: const [AutofillHints.newPassword],
                          ),
                        ),
                        const VerticalSpacing(32),
                        Text(L10n.tr().confirmPassword, maxLines: 1, style: context.style14400),
                        const VerticalSpacing(8),
                        Directionality(
                          textDirection: TextDirection.ltr,

                          child: MainTextField(
                            prefix: SvgPicture.asset(Assets.lockIc),
                            controller: confirmPassword,
                            hintText: L10n.tr().confirmNewPassword,
                            bgColor: Colors.transparent,
                            isPassword: true,
                            validator: (value) {
                              if (value != password.text) {
                                return L10n.tr().passwordsDoNotMatch;
                              }
                              return null;
                            },
                            autofillHints: const [AutofillHints.newPassword],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const VerticalSpacing(70),
                  BlocConsumer<RegisterCubit, RegisterStates>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        Alerts.showToast(state.resp.msg, error: false);
                        VerifyOTPScreenRoute(
                          initPhone: req.phone,
                          data: state.resp.sessionId ?? '',
                          $extra: (
                            di<RegisterRepo>(),
                            (ctx) {
                              ctx.go(HomeScreen.route);
                            },
                          ),
                        ).push(context);
                      } else if (state is RegisterError) {
                        Alerts.showToast(state.error.message);
                      }
                    },
                    builder: (context, state) => Hero(
                      tag: Tags.btn,
                      child: MainBtn(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            TextInput.finishAutofillContext();
                            req = req.copyWith(password: password.text, passwordConfirmation: confirmPassword.text);
                            logger.d(req.toJson());
                            context.read<RegisterCubit>().register(req);
                          }
                        },
                        isLoading: state is RegisterLoading,
                        text: L10n.tr().confirm,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

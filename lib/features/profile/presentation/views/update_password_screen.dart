import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/profile/data/models/change_password_req.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';
import 'package:gazzer/features/profile/presentation/views/profile_screen.dart';
import 'package:go_router/go_router.dart';

part 'update_password_screen.g.dart';

@TypedGoRoute<UpodatePasswordRoute>(path: UpodatePasswordScreen.fullRoute)
@immutable
class UpodatePasswordRoute extends GoRouteData with _$UpodatePasswordRoute {
  const UpodatePasswordRoute({required this.$extra});
  final ProfileCubit $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider.value(value: $extra, child: const UpodatePasswordScreen());
  }
}

class UpodatePasswordScreen extends StatefulWidget {
  const UpodatePasswordScreen({super.key});
  static const endpoint = 'update-password';
  static const fullRoute = '${ProfileScreen.route}/$endpoint';

  @override
  State<UpodatePasswordScreen> createState() => _UpodatePasswordScreenState();
}

class _UpodatePasswordScreenState extends State<UpodatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final currentPassword = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    currentPassword.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ClassicAppBar(),
      // backgroundColor: Co.secText,
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
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(L10n.tr().currentPassword, style: TStyle.blackSemi(14)),
                    const VerticalSpacing(8),
                    MainTextField(
                      showBorder: false,
                      controller: currentPassword,
                      hintText: L10n.tr().currentPassword,
                      bgColor: Co.secText,
                      isPassword: true,
                      validator: Validators.notEmpty,
                      autofillHints: [AutofillHints.password],
                    ),
                    const VerticalSpacing(16),
                    Text(L10n.tr().newPassword, style: TStyle.blackSemi(14)),
                    const VerticalSpacing(8),
                    MainTextField(
                      showBorder: false,

                      controller: password,
                      hintText: L10n.tr().yourNewPassword,
                      bgColor: Co.secText,
                      isPassword: true,
                      validator: Validators.passwordValidation,
                      autofillHints: [AutofillHints.newPassword],
                    ),
                    const VerticalSpacing(16),
                    Text(L10n.tr().confirmPassword, style: TStyle.blackSemi(14)),
                    const VerticalSpacing(8),
                    MainTextField(
                      showBorder: false,

                      controller: confirmPassword,
                      hintText: L10n.tr().confirmNewPassword,
                      bgColor: Co.secText,
                      isPassword: true,
                      validator: (value) {
                        if (value != password.text) {
                          return L10n.tr().passwordsDoNotMatch;
                        }
                        return null;
                      },
                      autofillHints: [AutofillHints.newPassword],
                    ),
                  ],
                ),
              ),

              const VerticalSpacing(40),
              BlocConsumer<ProfileCubit, ProfileStates>(
                listener: (context, state) {
                  if (state is ChangePasswordSuccess) {
                    Alerts.showToast(state.message, error: false);
                    context.pop();
                  }
                },
                builder: (context, state) => MainBtn(
                  isLoading: state is ChangePasswordLoading,
                  bgColor: Co.secondary,
                  onPressed: () {
                    if (_formKey.currentState?.validate() != true) return;
                    TextInput.finishAutofillContext();
                    context.read<ProfileCubit>().changePassword(
                      ChangePasswordReq(currentPassword: currentPassword.text, newPassword: password.text),
                    );
                  },
                  textStyle: TStyle.mainwSemi(15),
                  child: Text(L10n.tr().continu, style: TStyle.whiteSemi(16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

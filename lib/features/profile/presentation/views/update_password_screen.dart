import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/profile/data/models/change_password_req.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';
import 'package:go_router/go_router.dart';

part 'update_password_screen.g.dart';

@TypedGoRoute<UpodatePasswordRoute>(path: UpodatePasswordScreen.fullRoute)
@immutable
class UpodatePasswordRoute extends GoRouteData with _$UpodatePasswordRoute {
  const UpodatePasswordRoute({required this.$extra});
  final ProfileCubit $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider.value(
      value: $extra,
      child: const UpodatePasswordScreen(),
    );
  }
}

class UpodatePasswordScreen extends StatefulWidget {
  const UpodatePasswordScreen({super.key});

  static const endpoint = '/update-password';
  static const fullRoute = endpoint;

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
      appBar:  MainAppBar(),
      // backgroundColor: Co.secText,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: AppConst.defaultHrPadding,
          children: [
            const Center(
              child: VectorGraphicsWidget(
                Assets.assetsSvgCharacter,
                height: 130,
              ),
            ),
            Text(
              L10n.tr().resetPassword,
              style: context.style32700.copyWith(color: Co.purple),
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(32),
            AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(L10n.tr().currentPassword, style: context.style14400),
                  const VerticalSpacing(8),
                  MainTextField(
                    controller: currentPassword,
                    hintText: L10n.tr().currentPassword,
                    bgColor: Colors.transparent,
                    isPassword: true,
                    prefix: const VectorGraphicsWidget(Assets.lockIc),

                    validator: Validators.notEmpty,
                    autofillHints: const [AutofillHints.newPassword],
                  ),

                  const VerticalSpacing(16),
                  Text(L10n.tr().newPassword, style: context.style14400),
                  const VerticalSpacing(8),
                  MainTextField(
                    controller: password,
                    hintText: L10n.tr().yourNewPassword,
                    bgColor: Colors.transparent,
                    isPassword: true,
                    prefix: const VectorGraphicsWidget(Assets.lockIc),

                    validator: Validators.passwordValidation,
                    autofillHints: const [AutofillHints.newPassword],
                  ),
                  const VerticalSpacing(16),
                  Text(L10n.tr().confirmPassword, style: context.style14400),
                  const VerticalSpacing(8),
                  MainTextField(
                    controller: confirmPassword,
                    hintText: L10n.tr().confirmNewPassword,
                    bgColor: Colors.transparent,
                    isPassword: true,
                    prefix: const VectorGraphicsWidget(Assets.lockIc),

                    validator: (value) {
                      if (value != password.text) {
                        return L10n.tr().passwordsDoNotMatch;
                      }
                      return null;
                    },
                    autofillHints: const [AutofillHints.newPassword],
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
                onPressed: () {
                  if (_formKey.currentState?.validate() != true) return;
                  TextInput.finishAutofillContext();
                  context.read<ProfileCubit>().changePassword(
                    ChangePasswordReq(
                      currentPassword: currentPassword.text,
                      newPassword: password.text,
                    ),
                  );
                },
                text: L10n.tr().confirm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

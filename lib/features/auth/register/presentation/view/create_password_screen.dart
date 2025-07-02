import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_states.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key, required this.req});
  final RegisterRequest req;
  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ClassicAppBar(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Co.purple.withAlpha(50), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: AppConst.defaultHrPadding,
            children: [
              Center(child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
              Row(
                children: [GradientText(text: "Create Password", style: TStyle.mainwBold(32), gradient: Grad.textGradient)],
              ),
              const VerticalSpacing(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text("create password to veritfy.", maxLines: 2, style: TStyle.greySemi(16), textAlign: TextAlign.center),
              ),
              const VerticalSpacing(32),
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Password", style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    MainTextField(
                      controller: password,
                      hintText: "Your New Password",
                      bgColor: Colors.transparent,
                      isPassword: true,
                      validator: Validators.moreThanSix,
                      autofillHints: [AutofillHints.newPassword],
                    ),
                    const VerticalSpacing(32),
                    Text("Confirm Password", style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    MainTextField(
                      controller: confirmPassword,
                      hintText: "Confirm New Password",
                      bgColor: Colors.transparent,
                      isPassword: true,
                      validator: (v) {
                        if (v != password.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      autofillHints: [AutofillHints.newPassword],
                    ),
                  ],
                ),
              ),

              const VerticalSpacing(70),
              BlocConsumer<RegisterCubit, RegisterStates>(
                listener: (context, state) {},
                builder: (context, state) => Hero(
                  tag: Tags.btn,
                  child: OptionBtn(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        TextInput.finishAutofillContext();
                        final req = widget.req.copyWith(password: password.text, passwordConfirmation: confirmPassword.text);
                        context.read<RegisterCubit>().register(req);
                      }
                    },
                    isLoading: state is RegisterLoading,
                    textStyle: TStyle.mainwSemi(15),
                    bgColor: Colors.transparent,
                    child: GradientText(text: "Continue", style: TStyle.blackSemi(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

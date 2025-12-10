// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_state.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/loading_full_screen.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_events.dart';
import 'package:gazzer/features/addresses/presentation/views/add_edit_address_screen.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/loyalty_program_hero_one.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/tier_visual_details.dart';
import 'package:gazzer/features/profile/data/models/update_profile_req.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';
import 'package:gazzer/features/profile/presentation/views/component/profile_verify_otp_sheet.dart';
import 'package:gazzer/features/profile/presentation/views/component/udpate_account_sheet.dart';
import 'package:gazzer/features/profile/presentation/views/delete_account_screen.dart';
import 'package:gazzer/features/profile/presentation/views/update_password_screen.dart';
import 'package:gazzer/features/profile/presentation/views/widgets/address_card.dart';
import 'package:gazzer/features/profile/presentation/views/widgets/language_custom_dropdown.dart';
import 'package:gazzer/features/wallet/presentation/views/wallet_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'component/account_information_component.dart';
part 'component/invite_earn_component.dart';
part 'component/profile_addresses_component.dart';
part 'component/profile_navigation_component.dart';
part 'component/settings_preference_component.dart';
part 'widgets/profile_action_items.dart';
part 'widgets/profile_header_widget.dart';
part 'widgets/theme_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const route = '/profile';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<ProfileCubit>(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProfileCubit>();
          return BlocConsumer<ProfileCubit, ProfileStates>(
            listener: (context, state) async {
              if (state is ProfileErrorStates) {
                Alerts.showToast(state.message);
              } else if (state is UpdateSuccessWithClient) {
                Alerts.showToast(state.message, error: false);
              } else if (state is UpdateSuccessWithSession) {
                if (ModalRoute.of(context)?.isCurrent == true) {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    useSafeArea: true,
                    builder: (context) => BlocProvider.value(
                      value: cubit,
                      child: ProfileVerifyOtpScreen(sessionId: state.sessionId, req: state.req),
                    ),
                  );
                }
              }
            },

            builder: (context, state) => LoadingFullScreen(
              isLoading: state is ProfileLoadingStates,
              child: Scaffold(
                appBar: const MainAppBar(),
                body: SafeArea(
                  child: BlocConsumer<AppSettingsCubit, AppSettingsState>(
                    listenWhen: (previous, current) => previous.lang != current.lang,
                    listener: (context, state) {
                      di<AddressesBus>().refreshAddresses();
                    },
                    buildWhen: (previous, current) => previous.lang != current.lang || previous.isDarkMode != current.isDarkMode,
                    builder: (context, state) {
                      return ProfileContentBody(cubit: cubit);
                    },
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

// Reusable profile content widget
class ProfileContentBody extends StatelessWidget {
  const ProfileContentBody({super.key, required this.cubit, this.customHeader});

  final ProfileCubit cubit;
  final Widget? customHeader;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (cubit.client?.tierName != null)
            Container(
              color: allTiersDetails[cubit.client!.tierName!.toLowerCase()]!.mainColor,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cubit.client!.tierName!, style: TStyle.robotBlackMedium().copyWith(color: Co.white)),
                  SvgPicture.asset(allTiersDetails[cubit.client!.tierName!.toLowerCase()]!.logo),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                if (cubit.client != null) ...[
                  customHeader ?? _ProfileHeaderWidget(cubit.client!),
                  const VerticalSpacing(12),

                  _AccountInformationComponent(cubit.client!),
                  const VerticalSpacing(12),
                  _ProfileAddressesComponent(),
                  const VerticalSpacing(12),
                  _ProfileNavigationComponent(),
                  const VerticalSpacing(12),
                  _InviteEarnComponent(),
                  const VerticalSpacing(12),
                ],
                _SettingsPreferenceComponent(cubit.client),
                const VerticalSpacing(12),

                if (cubit.client != null) ...[
                  _SignOutButton(cubit: cubit),
                  const VerticalSpacing(12),
                  _DeleteAccountItem(cubit: cubit),
                ] else ...[
                  MainBtn(
                    onPressed: () {
                      context.push(LoginScreen.route);
                    },
                    bgColor: Co.purple,
                    radius: 16,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    child: Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Assets.signOutIc),

                        Text(
                          L10n.tr().login,
                          style: TStyle.robotBlackRegular().copyWith(color: Co.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

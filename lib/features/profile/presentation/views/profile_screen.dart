// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:gazzer/core/presentation/views/widgets/icons/main_switcher.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_events.dart';
import 'package:gazzer/features/addresses/presentation/views/add_edit_address_screen.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/profile/data/models/update_profile_req.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';
import 'package:gazzer/features/profile/presentation/views/component/profile_verify_otp_sheet.dart';
import 'package:gazzer/features/profile/presentation/views/component/udpate_account_sheet.dart';
import 'package:gazzer/features/profile/presentation/views/delete_account_screen.dart';
import 'package:gazzer/features/profile/presentation/views/update_password_screen.dart';
import 'package:gazzer/features/profile/presentation/views/widgets/address_card.dart';
import 'package:gazzer/features/profile/presentation/views/widgets/language_drop_list.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'component/account_information_component.dart';
part 'component/profile_addresses_component.dart';
part 'component/settings_preference_component.dart';
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
                      child: ProfileVerifyOtpScreen(
                        sessionId: state.sessionId,
                        req: state.req,
                      ),
                    ),
                  );
                }
              }
            },

            builder: (context, state) => LoadingFullScreen(
              isLoading: state is ProfileLoadingStates,
              child: Scaffold(
                appBar: const MainAppBar(
                  showLanguage: false,
                  showCart: false,
                ),
                body: SafeArea(
                  child: BlocConsumer<AppSettingsCubit, AppSettingsState>(
                    listenWhen: (previous, current) => previous.lang != current.lang,
                    listener: (context, state) {
                      di<AddressesBus>().refreshAddresses();
                    },
                    buildWhen: (previous, current) => previous.lang != current.lang || previous.isDarkMode != current.isDarkMode,
                    builder: (context, state) {
                      return ListView(
                        padding: AppConst.defaultPadding,
                        children: [
                          if (cubit.client != null) ...[
                            _ProfileHeaderWidget(cubit.client!),
                            const VerticalSpacing(32),
                            _AccountInformationComponent(cubit.client!),
                            const VerticalSpacing(32),
                            _ProfileAddressesComponent(),
                            const VerticalSpacing(32),
                          ],
                          _SettingsPreferenceComponent(cubit.client),
                        ],
                      );
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

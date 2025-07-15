// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_state.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_switcher.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';
import 'package:gazzer/features/profile/presentation/views/widgets/address_card.dart';
import 'package:gazzer/features/profile/presentation/views/widgets/language_drop_list.dart';

part 'component/account_information_component.dart';
part 'component/profile_addresses_component.dart';
part 'component/settings_preference_component.dart';
part 'widgets/profile_header_widget.dart';
part 'widgets/theme_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ClientEntity? client;

  @override
  void initState() {
    client = Session().client;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        showLanguage: false,
        showCart: false,
      ),
      body: SafeArea(
        child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
          buildWhen: (previous, current) => previous.lang != current.lang || previous.isDarkMode != current.isDarkMode,
          builder: (context, state) {
            return ListView(
              padding: AppConst.defaultPadding,
              children: [
                if (client != null) ...[
                  _ProfileHeaderWidget(),
                  const VerticalSpacing(32),
                  _AccountInformationComponent(),
                  const VerticalSpacing(32),
                  _ProfileAddressesComponent(),
                  const VerticalSpacing(32),
                ],
                _SettingsPreferenceComponent(client),
              ],
            );
          },
        ),
      ),
    );
  }
}

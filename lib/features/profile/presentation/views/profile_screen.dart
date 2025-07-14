import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';
import 'package:gazzer/features/profile/presentation/views/widgets/address_card.dart';

part 'component/account_information_component.dart';
part 'component/profile_addresses_component.dart';
part 'widgets/profile_header_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DoubledDecoratedWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MainAppBar(showLanguage: false, showCart: false, iconsColor: Co.secondary, bacButtonColor: Co.secondary),
        body: ListView(
          padding: AppConst.defaultPadding,
          children: [
            ProfileHeaderWidget(),
            VerticalSpacing(32),
            _AccountInformationComponent(),
            VerticalSpacing(32),
            _ProfileAddressesComponent(),
          ],
        ),
      ),
    );
  }
}

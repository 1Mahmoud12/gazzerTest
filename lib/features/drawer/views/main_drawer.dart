import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';
import 'package:gazzer/features/profile/presentation/views/component/profile_verify_otp_sheet.dart';
import 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  static const String route = '/menu';

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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
                appBar: MainAppBar(title: L10n.tr().myProfile),
                body: SafeArea(
                  child: BlocConsumer<AppSettingsCubit, AppSettingsState>(
                    listenWhen: (previous, current) => previous.lang != current.lang,
                    listener: (context, state) {
                      di<AddressesBus>().refreshAddresses();
                    },
                    buildWhen: (previous, current) => previous.lang != current.lang || previous.isDarkMode != current.isDarkMode,
                    builder: (context, state) {
                      return ProfileContentBody(
                        cubit: cubit,
                        customHeader: cubit.client != null ? ProfileHeaderContent(client: cubit.client!) : null,
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

// Custom profile header content widget for expanded state
class ProfileHeaderContent extends StatelessWidget {
  const ProfileHeaderContent({super.key, required this.client});

  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   spacing: 32,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(L10n.tr().goldenAccountUser, style: TStyle.primaryBold(13, font: FFamily.inter)),
        //     CircleAvatar(
        //       radius: 18,
        //       backgroundColor: Co.secondary,
        //       child: SvgPicture.asset(Assets.assetsSvgCup, height: 22, width: 22, colorFilter: const ColorFilter.mode(Co.dark, BlendMode.srcIn)),
        //     ),
        //   ],
        // ),
        const VerticalSpacing(24),
        Row(
          spacing: 20,
          children: [
            Badge(
              label: IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero,
                  backgroundColor: Co.purple,
                ),
                icon: SvgPicture.asset(Assets.assetsSvgEdit, height: 18, width: 18),
              ),
              alignment: const Alignment(0.65, 0.65),
              backgroundColor: Colors.transparent,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Co.white,
                child: Padding(
                  padding: const EdgeInsetsGeometry.all(2),
                  child: ClipOval(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CustomNetworkImage(
                        client.image ??
                            'https://cdni.iconscout.com/illustration/premium/thumb/female-user-image-illustration-download-in-svg-png-gif-file-formats--person-girl-business-pack-illustrations-6515859.png?f=webp',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(client.clientName, style: TStyle.robotBlackMedium()),
                  if (client.email != null)
                    Text(client.email ?? L10n.tr().notSetYet, style: TStyle.robotBlackMedium().copyWith(color: Colors.black87)),
                  const SizedBox.shrink(),
                  Text('${L10n.tr().memberSince} ${client.formatedCreatedAt}', style: TStyle.robotBlackMedium()),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

part of '../profile_screen.dart';

class _AccountInformationComponent extends StatelessWidget {
  const _AccountInformationComponent(this.client);
  final ClientEntity client;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.tr().accountInformation,
          style: TStyle.primaryBold(16),
        ),
        Divider(height: 15, thickness: 1, color: Co.purple.withAlpha(90)),
        ProfileInformationRow(
          icon: Assets.assetsSvgUser,
          title: L10n.tr().fullName,
          value: client.clientName,
        ),
        ProfileInformationRow(
          icon: Icons.email_outlined,
          title: L10n.tr().emailAddress,
          value: client.email ?? L10n.tr().notSetYet,
        ),
        ProfileInformationRow(
          icon: Icons.phone_outlined,
          title: L10n.tr().mobileNumber,
          value: client.phoneNumber,
        ),
        MainBtn(
          onPressed: () async {
            final res = await showModalBottomSheet<UpdateProfileReq>(
              context: context,
              backgroundColor: Co.secText,
              isScrollControlled: true,
              builder: (context) {
                return const UdpateAccountSheet();
              },
            );
            if (res != null && context.mounted) context.read<ProfileCubit>().updateProfile(res);
          },
          bgColor: Co.secondary,
          radius: 16,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            spacing: 16,
            children: [
              SvgPicture.asset(
                Assets.assetsSvgEditSquare,
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
              ),
              Expanded(
                child: Text(
                  L10n.tr().editAccountInformation,
                  style: TStyle.primaryBold(14, font: FFamily.inter),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        BlocListener<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is RequestDeleteAccountSuccess && ModalRoute.of(context)?.isCurrent == true) {
              context.myPush(
                BlocProvider.value(
                  value: cubit,
                  child: DeleteAccountScreen(sessionId: state.sessionId),
                ),
              );
            } else if (state is RequestDeleteAccountError) {
              Alerts.showToast(state.message);
            }
          },
          child: MainBtn(
            onPressed: () async {
              final res = await showModalBottomSheet<bool>(
                context: context,
                backgroundColor: Co.secText,
                constraints: const BoxConstraints(minHeight: 260),
                useSafeArea: true,
                builder: (context) => const DeleteAccountConfirmSheet(),
              );
              if (res == true) cubit.requestDeleteAccount();
            },
            bgColor: Colors.transparent,
            borderColor: Co.purple,
            radius: 16,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Row(
              spacing: 16,
              children: [
                const Icon(CupertinoIcons.delete, size: 20, color: Co.purple),
                Expanded(
                  child: Text(
                    L10n.tr().deleteAccount,
                    style: TStyle.primaryBold(14, font: FFamily.inter),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileInformationRow extends StatelessWidget {
  /// [icon] is either Svg (String) or IconData
  const ProfileInformationRow({super.key, required this.icon, required this.title, required this.value});

  final dynamic icon;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        if (icon is IconData)
          Icon(
            icon,
            size: 32,
            color: Co.secondary,
          )
        else
          SvgPicture.asset(
            icon,
            height: 32,
            width: 32,
          ),
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TStyle.blackRegular(14, font: FFamily.inter),
            ),
            Text(
              value,
              style: TStyle.primaryBold(14, font: FFamily.inter),
            ),
          ],
        ),
      ],
    );
  }
}

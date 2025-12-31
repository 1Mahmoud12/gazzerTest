part of '../profile_screen.dart';

class _AccountInformationComponent extends StatelessWidget {
  const _AccountInformationComponent(this.client);
  final ClientEntity client;
  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      title: L10n.tr().accountInformation,
      initiallyExpanded: true,
      icon: Assets.fullNameIc,
      body: Column(
        spacing: 16,
        children: [
          ProfileInformationRow(icon: Assets.fullNameIc, title: L10n.tr().fullName, value: client.clientName),
          ProfileInformationRow(icon: Icons.email_outlined, title: L10n.tr().emailAddress, value: client.email ?? L10n.tr().notSetYet),
          ProfileInformationRow(
            icon: Icons.phone_outlined,
            title: L10n.tr().mobileNumber,
            value: '${L10n.isAr(context) ? '' : '(+20)'} ${client.phoneNumber} ${L10n.isAr(context) ? '(20+)' : ''}',
          ),
          Row(
            children: [
              Expanded(
                child: MainBtn(
                  onPressed: () async {
                    final res = await showModalBottomSheet<UpdateProfileReq>(
                      context: context,
                      //backgroundColor: Co.secText,
                      isScrollControlled: true,
                      builder: (context) {
                        return const UdpateAccountSheet();
                      },
                    );
                    if (res != null && context.mounted) {
                      context.read<ProfileCubit>().updateProfile(res);
                    }
                  },
                  bgColor: Co.purple,
                  radius: 24,
                  child: FittedBox(
                    child: Text(
                      L10n.tr().editAccountInformation,
                      style: TStyle.robotBlackRegular().copyWith(color: Co.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MainBtn(
                  onPressed: () async {
                    final cubit = context.read<ProfileCubit>();
                    UpodatePasswordRoute($extra: cubit).push(context);
                  },
                  bgColor: Colors.transparent,
                  borderColor: Co.purple,
                  radius: 24,
                  child: Text(L10n.tr().changePassword, style: TStyle.robotBlackRegular(), textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      ),
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
        if (icon is IconData) Icon(icon, size: 32, color: Co.secondary) else SvgPicture.asset(icon, height: 32, width: 32),
        Expanded(
          child: Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TStyle.robotBlackMedium().copyWith(color: Co.darkGrey)),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(value, style: TStyle.robotBlackRegular()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

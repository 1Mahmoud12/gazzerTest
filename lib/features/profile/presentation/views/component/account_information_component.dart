part of '../profile_screen.dart';

class _AccountInformationComponent extends StatelessWidget {
  const _AccountInformationComponent();

  @override
  Widget build(BuildContext context) {
    final client = Session().client;
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
          value: client?.clientName ?? "Client Name",
        ),
        ProfileInformationRow(
          icon: Icons.email_outlined,
          title: L10n.tr().emailAddress,
          value: client?.email ?? "Client Email",
        ),
        ProfileInformationRow(
          icon: Icons.phone_outlined,
          title: L10n.tr().mobileNumber,
          value: client?.phoneNumber ?? "Client Mobile",
        ),
        MainBtn(
          onPressed: () {},
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

        MainBtn(
          onPressed: () {},
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

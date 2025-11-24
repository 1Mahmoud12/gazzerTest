part of '../profile_screen.dart';

class _ProfileHeaderWidget extends StatelessWidget {
  const _ProfileHeaderWidget(this.client);
  final ClientEntity client;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GradientTextWzShadow(
            text: L10n.tr().userProfile,
            style: TStyle.primaryBold(20),
            shadow: const BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 2, offset: Offset(0, 2)),
          ),
        ),
        const VerticalSpacing(8),
        Row(
          spacing: 32,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(L10n.tr().goldenAccountUser, style: TStyle.primaryBold(13, font: FFamily.inter)),
            CircleAvatar(
              radius: 18,
              backgroundColor: Co.secondary,
              child: SvgPicture.asset(
                Assets.assetsSvgCup,
                height: 22,
                width: 22,
                colorFilter: const ColorFilter.mode(Co.dark, BlendMode.srcIn),
              ),
            ),
          ],
        ),
        const VerticalSpacing(24),
        SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              Badge(
                label: IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                    backgroundColor: const Color(0xff3B82F6),
                  ),
                  icon: SvgPicture.asset(
                    Assets.assetsSvgEdit,
                    height: 18,
                    width: 18,
                  ),
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
                              "https://cdni.iconscout.com/illustration/premium/thumb/female-user-image-illustration-download-in-svg-png-gif-file-formats--person-girl-business-pack-illustrations-6515859.png?f=webp",
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
                    Text(client.clientName, style: TStyle.primarySemi(16)),
                    if (client.email != null)
                      Text(
                        client.email ?? L10n.tr().notSetYet,
                        style: TStyle.primaryRegular(12, font: FFamily.inter).copyWith(
                          color: Colors.black87,
                        ),
                      ),
                    const SizedBox.shrink(),
                    Text("${L10n.tr().memberSince} ${client.formatedCreatedAt}", style: TStyle.blackRegular(12, font: FFamily.inter)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

part of '../profile_screen.dart';

class _ProfileHeaderWidget extends StatelessWidget {
  const _ProfileHeaderWidget();

  @override
  Widget build(BuildContext context) {
    final client = Session().client;
    return Column(
      children: [
        Center(child: Text(L10n.tr().userProfile, style: TStyle.whiteBold(20))),
        const VerticalSpacing(8),
        Row(
          spacing: 32,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(L10n.tr().goldenAccountUser, style: TStyle.secondaryBold(13, font: FFamily.inter)),
            SvgPicture.asset(Assets.assetsSvgCup, height: 24, width: 24),
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
                        child: Image.network(
                          client?.image ??
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
                  children: [
                    Text(client?.clientName ?? 'Client Name', style: TStyle.whiteSemi(16)),
                    Text(
                      client?.email ?? 'client@email.com',
                      style: TStyle.whiteRegular(12, font: FFamily.inter).copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const Spacer(),
                    Text("${L10n.tr().memberSince} ${client?.createdAt ?? 'Jan 2025'}", style: TStyle.whiteRegular(12, font: FFamily.inter)),
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

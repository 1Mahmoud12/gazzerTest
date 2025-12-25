part of '../profile_screen.dart';

class _ProfileHeaderWidget extends StatelessWidget {
  const _ProfileHeaderWidget(this.client);
  final ClientEntity client;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  // if (client.email != null)
                  //   Text(client.email ?? L10n.tr().notSetYet, style: TStyle.robotBlackMedium().copyWith(color: Colors.black87)),
                  // const SizedBox.shrink(),
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

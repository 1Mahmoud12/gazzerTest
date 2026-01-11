part of '../profile_screen.dart';

class _ProfileHeaderWidget extends StatefulWidget {
  const _ProfileHeaderWidget(this.client);
  final ClientEntity client;

  @override
  State<_ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<_ProfileHeaderWidget> {
  File? _selectedAvatar;

  Future<File?> _showImageSourceDialog() async {
    return ImageSourcePickerBottomSheet.show(context: context);
  }

  Future<void> _updateAvatar(File? avatarFile) async {
    if (avatarFile == null) return;

    final cubit = context.read<ProfileCubit>();
    final client = cubit.client;
    if (client == null) return;

    final req = UpdateProfileReq(
      name: client.clientName,
      phone: client.phoneNumber,
      email: client.email,
      avatar: avatarFile,
    );

    await cubit.updateProfile(req);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 20,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Co.white,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: ClipOval(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: _selectedAvatar != null
                            ? Image.file(_selectedAvatar!, fit: BoxFit.cover)
                            : BlocBuilder<ProfileCubit, ProfileStates>(
                                builder: (context, state) => CustomNetworkImage(
                                  widget.client.image ??
                                      'https://cdni.iconscout.com/illustration/premium/thumb/female-user-image-illustration-download-in-svg-png-gif-file-formats--person-girl-business-pack-illustrations-6515859.png?f=webp',
                                ),
                              ),
                      ),
                    ),
                  ),
                ),

                Positioned.directional(
                  textDirection: Directionality.of(context),
                  bottom: 1,
                  end: 1,

                  child: IconButton(
                    onPressed: () async {
                      final file = await _showImageSourceDialog();
                      if (file != null) {
                        await _updateAvatar(file);
                      }
                    },
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                      backgroundColor: Co.purple,
                    ),
                    icon: SvgPicture.asset(
                      Assets.assetsSvgEdit,
                      height: 18,
                      width: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(widget.client.clientName, style: context.style20500),
                  // if (widget.client.email != null)
                  //   Text(widget.client.email ?? L10n.tr().notSetYet, style: context.style16500.copyWith(color: Colors.black87)),
                  // const SizedBox.shrink(),
                  Text(
                    '${L10n.tr().memberSince} ${widget.client.formatedCreatedAt}',
                    style: context.style12400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

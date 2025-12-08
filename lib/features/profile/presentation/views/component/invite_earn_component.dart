part of '../profile_screen.dart';

class _InviteEarnComponent extends StatelessWidget {
  const _InviteEarnComponent();

  String _getReferralCode(ClientEntity? client) {
    // Use client ID as referral code, or generate from phone number
    if (client == null) return '';
    return client.id.toString();
  }

  String _getAppLink() {
    // TODO: Replace with actual app store links or deep link
    return 'https://gazzer.app/download?ref=${_getReferralCode(Session().client)}';
  }

  Future<void> _copyCode(BuildContext context, String code) async {
    await Clipboard.setData(ClipboardData(text: code));
  }

  Future<void> _shareLink(BuildContext context) async {
    final link = _getAppLink();
    // Copy link to clipboard and show toast
    await Clipboard.setData(ClipboardData(text: link));
  }

  @override
  Widget build(BuildContext context) {
    final client = Session().client;
    if (client == null) return const SizedBox.shrink();

    final referralCode = _getReferralCode(client);

    return ExpandableWidget(
      title: L10n.tr().inviteAndEarn,
      icon: Assets.inviteIc,
      body: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Earn 30 EGP when your friend places their first order.', style: TStyle.robotBlackRegular().copyWith(color: Co.darkGrey)),
          const VerticalSpacing(8),
          // Referral Code Section
          Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(L10n.tr().yourCode, style: TStyle.robotBlackMedium().copyWith(color: Co.darkGrey)),
                    const HorizontalSpacing(4),
                    Text(referralCode, style: TStyle.robotBlackMedium()),
                  ],
                ),
              ),
              MainBtn(
                onPressed: () => _copyCode(context, referralCode),
                bgColor: Co.purple,
                radius: 12,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(L10n.tr().copyCode, style: TStyle.whiteSemi(14)),
              ),
            ],
          ),
          const VerticalSpacing(8),
          // Share Link Section
          Row(
            children: [
              Expanded(child: Text(L10n.tr().shareApplicationLink, style: TStyle.robotBlackMedium())),
              MainBtn(
                onPressed: () => _shareLink(context),
                bgColor: Co.purple,
                radius: 12,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(L10n.tr().shareLink, style: TStyle.whiteSemi(14)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

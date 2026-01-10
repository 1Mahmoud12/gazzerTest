part of '../profile_screen.dart';

class _InviteEarnComponent extends StatelessWidget {
  const _InviteEarnComponent();

  Future<void> _copyCode(BuildContext context, String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    Alerts.showToast(L10n.tr().codeAppliedSuccessfully, error: false);
  }

  Future<void> _shareLink(BuildContext context, String link) async {
    await Clipboard.setData(ClipboardData(text: link));
    Alerts.showToast(L10n.tr().link_copied_to_clipboard, error: false);
  }

  @override
  Widget build(BuildContext context) {
    final client = Session().client;
    if (client == null || client.referral == null) {
      return const SizedBox.shrink();
    }

    final referral = client.referral!;
    final referralCode = referral.code ?? '';
    final shareLink = referral.shareLink ?? '';

    if (referralCode.isEmpty) return const SizedBox.shrink();

    return ExpandableWidget(
      title: L10n.tr().inviteAndEarn,
      icon: Assets.inviteIc,
      body: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(client.referral?.shareMessage ?? '', style: context.style16400.copyWith(color: Co.darkGrey)),
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
                child: Text(
                  L10n.tr().copyCode,
                  style: context.style14400.copyWith(color: Co.white, fontWeight: TStyle.medium),
                ),
              ),
            ],
          ),
          const VerticalSpacing(8),
          // Share Link Section
          Row(
            children: [
              Expanded(child: Text(L10n.tr().shareApplicationLink, style: TStyle.robotBlackMedium())),
              MainBtn(
                onPressed: () => _shareLink(context, shareLink),
                bgColor: Co.purple,
                radius: 12,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  L10n.tr().shareLink,
                  style: context.style14400.copyWith(color: Co.white, fontWeight: TStyle.medium),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

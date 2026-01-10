import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/loyaltyProgram/domain/entities/loyalty_program_entity.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/tier_visual_details.dart';

class OurTierBenefitsWidget extends StatefulWidget {
  const OurTierBenefitsWidget({super.key, required this.tiers, required this.currentTierName, required this.tierVisuals});

  final List<TierBenefits> tiers;
  final String currentTierName;
  final Map<String, TierVisualDetails> tierVisuals;

  @override
  State<OurTierBenefitsWidget> createState() => _OurTierBenefitsWidgetState();
}

class _OurTierBenefitsWidgetState extends State<OurTierBenefitsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to current tier after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentTier();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentTier() {
    if (!_scrollController.hasClients) return;

    // Find the index of the current tier
    final currentTierLower = widget.currentTierName.toLowerCase();
    int? currentIndex;
    for (int i = 0; i < widget.tiers.length; i++) {
      final tier = widget.tiers[i];
      final nameKey = (tier.tier?.name ?? tier.tier?.displayName ?? '').toLowerCase();
      if (nameKey == currentTierLower) {
        currentIndex = i;
        break;
      }
    }

    if (currentIndex == null) return;

    // Calculate scroll position
    // Each card is 220px wide + 12px spacing = 232px per card
    const cardWidth = 220.0;
    const spacing = 12.0;
    final scrollPosition = currentIndex * (cardWidth + spacing);

    // Center the current tier in the viewport
    final screenWidth = MediaQuery.of(context).size.width;
    final centeredPosition = scrollPosition - (screenWidth / 2) + (cardWidth / 2);

    // Clamp to valid scroll range
    final maxScroll = _scrollController.position.maxScrollExtent;
    final clampedPosition = centeredPosition.clamp(0.0, maxScroll);

    _scrollController.animateTo(clampedPosition, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tiers.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(L10n.tr().ourTierBenefits, style: context.style16500),
        const SizedBox(height: 16),
        SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 12,
            children: widget.tiers.map((tier) {
              final nameKey = (tier.tier?.name ?? tier.tier?.displayName ?? '').toLowerCase();
              final visual = widget.tierVisuals[nameKey] ?? TierVisualResolver.resolve(tier.tier);
              final isCurrent = nameKey == widget.currentTierName.toLowerCase();
              return _TierBenefitsCard(tier: tier, visual: visual, isCurrent: isCurrent);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _TierBenefitsCard extends StatelessWidget {
  const _TierBenefitsCard({required this.tier, required this.visual, required this.isCurrent});

  final TierBenefits tier;
  final TierVisualDetails visual;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final title = tier.tier?.displayName ?? tier.tier?.name ?? '—';
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: visual.mainColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isCurrent ? Co.secondary : visual.mainColor.withOpacityNew(0.4), width: isCurrent ? 2 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${L10n.tr().level} $title', style: context.style16500.copyWith(color: visual.primaryTextColor)),
          const SizedBox(height: 12),
          ...tier.benefits.map(
            (benefit) => _BenefitRow(
              title: benefit.title ?? benefit.benefitType ?? '',
              isEnabled: benefit.isEnabled ?? false,
              textColor: visual.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.title, required this.isEnabled, required this.textColor});

  final String title;
  final bool isEnabled;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(isEnabled ? Icons.check_circle : Icons.radio_button_unchecked, size: 20, color: isEnabled ? Co.white : Co.white.withOpacityNew(0.5)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: context.style16400.copyWith(
                color: textColor,
                decorationColor: textColor,
                decoration: !isEnabled ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

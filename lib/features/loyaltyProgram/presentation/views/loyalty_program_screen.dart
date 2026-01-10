import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/loyaltyProgram/domain/entities/loyalty_program_entity.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/cubit/loyalty_program_cubit.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/cubit/loyalty_program_state.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/name_logo_loyalty_program.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/our_tier_benefits_widget.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/progress_loyalty_program.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/tier_visual_details.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/your_points_widget.dart';
import 'package:gazzer/features/wallet/presentation/views/wallet_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LoyaltyProgramScreen extends StatelessWidget {
  const LoyaltyProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Session().client == null) {
      return Scaffold(
        appBar: MainAppBar(
          iconsColor: Co.secondary,
          title: L10n.tr().loyaltyProgram,
          titleStyle: context.style20500.copyWith(color: Co.purple, fontWeight: TStyle.medium),
        ),
        body: Center(child: UnAuthComponent(msg: L10n.tr().pleaseLoginToUseLoyalty)),
      );
    }

    return BlocProvider(create: (_) => di<LoyaltyProgramCubit>()..load(), child: const _LoyaltyProgramView());
  }
}

class _LoyaltyProgramView extends StatelessWidget {
  const _LoyaltyProgramView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        iconsColor: Co.secondary,
        title: L10n.tr().loyaltyProgram,
        titleStyle: context.style20500.copyWith(color: Co.purple, fontWeight: TStyle.medium),
      ),
      body: BlocBuilder<LoyaltyProgramCubit, LoyaltyProgramState>(
        builder: (context, state) {
          if (state is LoyaltyProgramError) {
            return FailureComponent(
              message: state.message,
              onRetry: () {
                context.read<LoyaltyProgramCubit>().load();
              },
            );
          }
          return switch (state) {
            LoyaltyProgramInitial() || LoyaltyProgramLoading() => const Center(child: LoadingWidget()),
            LoyaltyProgramLoaded(:final data, :final isCached) => _buildLoaded(context, data, isCached),
            LoyaltyProgramError(:final message, :final cachedData) =>
              cachedData != null ? _buildLoaded(context, cachedData, true, errorMessage: message) : _ErrorView(message: state.message),
          };
        },
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, LoyaltyProgramEntity data, bool isCached, {String? errorMessage}) {
    final visuals = TierVisualResolver.resolve(data.currentTier);
    final bannerText = _bannerTextForVisual(context, visuals.bannerKey);
    final tierBenefits = data.tierBenefits;

    final tierProgress = data.tierProgress;
    final points = data.points;

    final spent = (tierProgress?.totalSpent ?? 0).toDouble();
    final needed = (tierProgress?.nextTier?.spentNeeded ?? spent).toDouble();
    final progress = (tierProgress?.progressPercentage ?? 0).toDouble() / 100.0;
    final durationDays = (tierProgress?.daysPeriod ?? 0).toInt();
    final nextTier = tierProgress?.nextTier == null ? null : tierProgress?.nextTier?.displayName ?? '';
    final progressNextTier = tierProgress?.nextTier == null ? null : (tierProgress?.nextTier?.spentNeeded ?? 0).toDouble();
    final minOrderCount = (data.tierProgress?.nextTier?.ordersNeeded ?? 0).toInt();

    final availablePoints = (points?.availablePoints ?? 0).toInt();
    final totalPoints = (points?.totalPoints ?? 0).toInt();
    final earningRate = points?.earningRate;
    final conversionRate = points?.conversionRate;
    final expiration = points?.expiresAt;
    final expirationFormatted = expiration == null ? '-' : DateFormat('dd-MM-yyyy').format(expiration);
    final nearingExpiry = (points?.pointsNearingExpiry ?? 0).toInt();
    final minProgress = data.currentTier?.minProgress ?? 0;
    final maxProgress = data.currentTier?.maxProgress ?? 0;

    final benefitsVisuals = {
      for (final tier in tierBenefits) (tier.tier?.name ?? tier.tier?.displayName ?? '').toLowerCase(): TierVisualResolver.resolve(tier.tier),
    };

    final bannerWidget = _ProgramContent(
      data: data,
      visuals: visuals,
      bannerText: bannerText,
      isCached: isCached,
      showBenefits: tierBenefits,
      spent: spent,
      requiredSpend: needed,
      progressNextTier: progressNextTier,
      nameNextTier: nextTier,
      progress: progress.clamp(0.0, 1.0),
      orderCount: minOrderCount,
      durationDays: durationDays,
      totalPoints: totalPoints,
      availablePoints: availablePoints,
      earningRate: earningRate,
      conversionRate: conversionRate,
      nearingExpiry: nearingExpiry,
      expirationDate: expirationFormatted,
      benefitsVisuals: benefitsVisuals,
      errorMessage: errorMessage,
      minProgress: minProgress,
      maxProgress: maxProgress,
    );

    return bannerWidget;
  }

  String _bannerTextForVisual(BuildContext context, String bannerKey) {
    final l10n = L10n.tr();
    return switch (bannerKey) {
      'heroBanner' => l10n.heroBanner,
      'winnerBanner' => l10n.winnerBanner,
      'gainerBanner' => l10n.gainerBanner,
      'silverBanner' => l10n.silverBanner,
      _ => l10n.heroBanner,
    };
  }
}

class _ProgramContent extends StatelessWidget {
  const _ProgramContent({
    required this.data,
    required this.visuals,
    required this.bannerText,
    required this.isCached,
    required this.showBenefits,
    required this.minProgress,
    required this.maxProgress,
    this.spent = 0,
    this.requiredSpend = 0,
    this.progress = 0,
    this.orderCount = 0,
    this.durationDays = 0,
    this.totalPoints = 0,
    this.availablePoints = 0,
    this.earningRate,
    this.conversionRate,
    this.nearingExpiry = 0,
    this.expirationDate = '-',
    this.benefitsVisuals = const {},
    this.errorMessage,
    this.nameNextTier,
    this.progressNextTier,
  });

  final LoyaltyProgramEntity data;
  final TierVisualDetails visuals;
  final String bannerText;
  final bool isCached;
  final List<TierBenefits> showBenefits;
  final String? nameNextTier;
  final double? progressNextTier;
  final double spent;
  final double requiredSpend;
  final double progress;
  final int orderCount;
  final int durationDays;
  final int totalPoints;
  final int availablePoints;
  final num minProgress;
  final num maxProgress;
  final EarningRate? earningRate;
  final ConversionRate? conversionRate;
  final int nearingExpiry;
  final String expirationDate;
  final Map<String, TierVisualDetails> benefitsVisuals;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final currentTierName = data.currentTier?.displayName ?? data.currentTier?.name ?? '—';
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<LoyaltyProgramCubit>().load(forceRefresh: true);
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        children: [
          Text(bannerText, style: context.style16500, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          NameLogoLoyaltyProgram(
            mainColor: visuals.mainColor,
            logo: visuals.logo,
            nameProgram: currentTierName,
            firstTextColor: visuals.primaryTextColor,
            secondTextColor: visuals.secondaryTextColor,
          ),
          const SizedBox(height: 16),
          ProgressLoyaltyPrograms(
            spentPoints: spent.toInt(),
            spendDuration: durationDays,
            totalPoints: spent.toInt(),
            maxProgramPoints: requiredSpend.toInt(),
            mainColor: visuals.mainColor,
            progress: progress.isFinite ? progress : 0,
            nameNextTier: nameNextTier,
            nameCurrentTier: data.currentTier?.name,
            progressNextTier: progressNextTier,
            minOrderCount: orderCount,
            minProgress: minProgress,
            maxProgress: maxProgress,
          ),
          const SizedBox(height: 16),
          YourPointsWidget(
            visual: visuals,
            availablePoints: availablePoints,
            earningPoints: (earningRate?.pointsPerAmount ?? 0).toInt(),
            earningPerPound: (earningRate?.amountUnit ?? 0).toInt(),
            conversionRate: (conversionRate?.points ?? 0).toInt(),
            conversionPound: (conversionRate?.egp ?? 0).toInt(),
            expirationPoints: nearingExpiry,
            expirationDate: expirationDate,
            totalPoints: totalPoints,
          ),
          const SizedBox(height: 16),
          OurTierBenefitsWidget(tiers: showBenefits, currentTierName: data.currentTier?.name ?? '', tierVisuals: benefitsVisuals),
          const SizedBox(height: 16),
          MainBtn(
            onPressed: () {
              context.push(WalletScreen.route);
            },
            child: Text(L10n.tr().viewWallet),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Co.red.withOpacityNew(0.6)),
            const SizedBox(height: 16),
            Text(
              message.isEmpty ? L10n.tr().somethingWentWrong : message,
              textAlign: TextAlign.center,
              style: context.style14400.copyWith(color: Co.red),
            ),
          ],
        ),
      ),
    );
  }
}

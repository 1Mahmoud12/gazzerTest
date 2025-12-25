import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/search/data/search_query.dart';
import 'package:gazzer/features/search/presentaion/cubit/search_cubit.dart';
import 'package:gazzer/features/search/presentaion/cubit/search_states.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return SizedBox(
      height: 40,
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) => ListView(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            _FilterItem(
              title: '${L10n.tr().sort} ${state.query.alpha.uncodeIcon}',
              isSelected: state.query.alpha != AlphaSort.none,
              // icon: Icon(
              //   state.query.ascendingAlphabetic ? Icons.arrow_upward_outlined : Icons.arrow_downward_outlined,
              //   color: Co.purple,
              //   size: 20,
              // ),
              onTap: () {
                context.read<SearchCubit>().performSearch(cubit.state.query.copyWith(alpha: state.query.alpha.next()));
              },
            ),
            _FilterItem(
              title: '${L10n.tr().rating} +4',
              isSelected: state.query.sortedByRate,
              onTap: () {
                context.read<SearchCubit>().performSearch(cubit.state.query.copyWith(sortedByRate: !state.query.sortedByRate));
              },
            ),
            _FilterItem(
              title: L10n.tr().under30mins,
              isSelected: state.query.sortByDeliveryTime,
              onTap: () {
                context.read<SearchCubit>().performSearch(cubit.state.query.copyWith(sortByDeliveryTime: !state.query.sortByDeliveryTime));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterItem extends StatelessWidget {
  const _FilterItem({required this.title, this.icon, required this.isSelected, required this.onTap});
  final String title;
  final Widget? icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12),
      child: InkWell(
        borderRadius: AppConst.defaultBorderRadius,
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            //  color: isSelected ? Co.secondary.withAlpha(80) : Colors.transparent,
            border: Border.all(color: isSelected ? Co.purple : Co.purple100, width: 2),
            borderRadius: AppConst.defaultBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 6,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TStyle.robotBlackMedium().copyWith(fontWeight: FontWeight.w400, color: isSelected ? Co.purple : null),
                ),
                if (icon != null) icon!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

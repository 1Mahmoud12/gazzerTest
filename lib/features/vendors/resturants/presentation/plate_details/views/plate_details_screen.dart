import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/failure_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/cubit/plate_details_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/cubit/plate_details_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/plate_options_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_extras_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_image_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_price_summary.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_summary_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/widgets/add_special_note.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'plate_details_screen.g.dart';

@TypedGoRoute<PlateDetailsRoute>(path: SinglePlateScreen.route)
@immutable
class PlateDetailsRoute extends GoRouteData with _$PlateDetailsRoute {
  const PlateDetailsRoute({required this.id});
  final int id;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<PlateDetailsCubit>(param1: id),
      child: const SinglePlateScreen(),
    );
  }
}

class SinglePlateScreen extends StatelessWidget {
  static const route = '/single-plate';
  const SinglePlateScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),

      body: BlocBuilder<PlateDetailsCubit, PlateDetailsStates>(
        builder: (context, state) {
          if (state is PlateDetailsError) {
            return FailureWidget(
              message: L10n.tr().couldnotLoadDataPleaseTryyAgain,
              onRetry: () => context.read<PlateDetailsCubit>().loadPlateDetails(),
            );
          }

          return Skeletonizer(
            enabled: state is PlateDetailsLoading,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),

              children: [
                ProductImageWidget(image: state.plate.image, plate: state.plate),
                ProductSummaryWidget(plate: state.plate),
                const VerticalSpacing(24),

                ...List.generate(
                  state.options.length,
                  (index) => PlateOptionsWidget(
                    option: state.options[index],
                    onSelection: (value) => true,
                  ),
                ),
                const VerticalSpacing(24),
                OrderedWithComponent(products: state.orderedWith),
                const VerticalSpacing(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AddSpecialNote(
                      onNoteChange: (note) {
                        // Handle note change if needed
                      },
                    ),
                  ],
                ),
                const VerticalSpacing(16),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const Skeleton.shade(child: ProductPriceSummary()),
    );
  }
}

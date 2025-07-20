import 'package:gazzer/features/intro/presentation/plan/views/diatery_lifestyle_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/frequancy_combos_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/health_focus_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/nuttration_support_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/supplements_screen.dart';
import 'package:go_router/go_router.dart';

final planScreens = [
  GoRoute(path: HealthFocusScreen.route, builder: (context, state) => const HealthFocusScreen()),
  GoRoute(path: DiateryLifestyleScreen.route, builder: (context, state) => const DiateryLifestyleScreen()),
  GoRoute(path: SupplementsScreen.route, builder: (context, state) => const SupplementsScreen()),
  GoRoute(path: NuttrationSupportScreen.route, builder: (context, state) => const NuttrationSupportScreen()),
  GoRoute(path: FrequancyCombosScreen.route, builder: (context, state) => const FrequancyCombosScreen()),
];

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Favorites Screen', style: TStyle.blackBold(24))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key, this.size = 32, this.padding = 8, this.hasContainer = false});
  final double size;
  final double padding;
  final bool hasContainer;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late bool isFav;
  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: 1, end: 1.25).animate(controller);
    isFav = false;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future _toggleFav() async {
    bool result = true;
    if (isFav) {
      // result = await context.read<FavoriteCubit>().removeFavorite(widget.prod.id!);
    } else {
      // result = await context.read<FavoriteCubit>().addFavorite(widget.prod);
    }
    if (result) {
      await Future.delayed(Durations.short1);
      if (mounted) _pulseAnmateFav();
    }
  }

  _pulseAnmateFav() {
    controller.forward().then((_) {
      setState(() {
        isFav = !isFav;
      });
      controller.reverse();
      controller.forward();
      controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = IconButton(
      onPressed: () async {
        SystemSound.play(SystemSoundType.click);
        _toggleFav();
      },
      style: IconButton.styleFrom(
        padding: EdgeInsets.all(widget.padding),
        shape: const CircleBorder(),
        minimumSize: Size.zero,
        iconSize: widget.size,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
      ),
      icon: ScaleTransition(
        scale: animation,
        child: Icon(isFav ? Icons.favorite : Icons.favorite_border_rounded, color: Co.secondary, size: widget.size),
      ),
    );
    if (!widget.hasContainer) return child;
    return DoubledDecoratedWidget(
      innerDecoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(6)),
      child: child,
    );
  }
}

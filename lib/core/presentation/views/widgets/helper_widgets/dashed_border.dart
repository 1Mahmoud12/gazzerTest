import 'package:flutter/material.dart';

class DashedBorder extends StatelessWidget {
  const DashedBorder({super.key, required this.width, required this.gap, this.color = Colors.black, this.thickness = 1});
  final double width;
  final double gap;
  final Color color;
  final double thickness;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: List.generate(
          constraints.maxWidth ~/ (gap + width),
          (index) => Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: gap / 2),
            child: SizedBox(
              width: width,
              height: thickness,
              child: ColoredBox(color: color),
            ),
          ),
        ),
      ),
    );
  }
}

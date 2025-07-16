import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';

class LoadingFullScreen extends StatefulWidget {
  const LoadingFullScreen({super.key, required this.isLoading, required this.child});
  final bool isLoading;
  final Widget child;

  @override
  State<LoadingFullScreen> createState() => _LoadingFullScreenState();
}

class _LoadingFullScreenState extends State<LoadingFullScreen> {
  late final ValueNotifier<bool> isLoading;
  @override
  void initState() {
    isLoading = ValueNotifier(widget.isLoading);
    super.initState();
  }

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoadingFullScreen oldWidget) {
    if (oldWidget.isLoading != widget.isLoading) {
      isLoading.value = widget.isLoading;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) => value ? SizedBox.expand(child: child) : const SizedBox.shrink(),
            child: const SizedBox.expand(
              child: ColoredBox(
                color: Colors.black45,

                child: Center(child: AdaptiveProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

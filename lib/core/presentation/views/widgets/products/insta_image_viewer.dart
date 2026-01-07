import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const _kRouteDuration = Duration(milliseconds: 300);

class InstaImageViewer extends StatelessWidget {
  const InstaImageViewer({
    super.key,
    required this.child,
    this.imageUrl,
    this.headers,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    this.disposeLevel,
    this.disableSwipeToDismiss = false,
    this.filePath,
  });

  final Widget child;

  final String? imageUrl;
  final String? filePath;

  final Map<String, String>? headers;

  final Color backgroundColor;

  final bool backgroundIsTransparent;

  final DisposeLevel? disposeLevel;

  final bool disableSwipeToDismiss;

  @override
  Widget build(BuildContext context) {
    final UniqueKey tag = UniqueKey();
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          if (imageUrl != null || filePath != null) {
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                barrierColor: backgroundIsTransparent ? Colors.transparent : backgroundColor,
                pageBuilder: (BuildContext context, _, __) {
                  return FullScreenViewer(
                    tag: tag,
                    backgroundColor: backgroundColor,
                    backgroundIsTransparent: backgroundIsTransparent,
                    disposeLevel: disposeLevel,
                    disableSwipeToDismiss: disableSwipeToDismiss,
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl!,
                            headers: headers,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          )
                        : Image.file(
                            File(filePath!),
                            errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error, color: Colors.red, size: 50)),
                          ),
                  );
                },
              ),
            );
          } else {
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                barrierColor: backgroundIsTransparent ? Colors.transparent : backgroundColor,
                pageBuilder: (BuildContext context, _, __) {
                  return FullScreenViewer(
                    tag: tag,
                    backgroundColor: backgroundColor,
                    backgroundIsTransparent: backgroundIsTransparent,
                    disposeLevel: disposeLevel,
                    disableSwipeToDismiss: disableSwipeToDismiss,
                    child: child,
                  );
                },
              ),
            );
          }
        },
        child: child,
      ),
    );
  }
}

enum DisposeLevel { high, medium, low }

class FullScreenViewer extends StatefulWidget {
  const FullScreenViewer({
    super.key,
    required this.child,
    required this.tag,
    required this.disableSwipeToDismiss,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    this.disposeLevel = DisposeLevel.medium,
  });

  final Widget child;
  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel? disposeLevel;
  final UniqueKey tag;
  final bool disableSwipeToDismiss;

  @override
  FullScreenViewerState createState() => FullScreenViewerState();
}

class FullScreenViewerState extends State<FullScreenViewer> {
  double? _initialPositionY = 0;

  double? _currentPositionY = 0;

  double _positionYDelta = 0;

  double _opacity = 1;

  double _disposeLimit = 150;

  Duration _animationDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    setDisposeLevel();
  }

  void setDisposeLevel() {
    if (widget.disposeLevel == DisposeLevel.high) {
      _disposeLimit = 300;
    } else if (widget.disposeLevel == DisposeLevel.medium) {
      _disposeLimit = 200;
    } else {
      _disposeLimit = 100;
    }
  }

  void _dragUpdate(DragUpdateDetails details) {
    setState(() {
      _currentPositionY = details.globalPosition.dy;
      _positionYDelta = _currentPositionY! - _initialPositionY!;
      setOpacity();
    });
  }

  void _dragStart(DragStartDetails details) {
    setState(() {
      _initialPositionY = details.globalPosition.dy;
    });
  }

  _dragEnd(DragEndDetails details) {
    if (_positionYDelta > _disposeLimit || _positionYDelta < -_disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _animationDuration = _kRouteDuration;
        _opacity = 1;
        _positionYDelta = 0;
      });

      Future.delayed(_animationDuration).then((_) {
        setState(() {
          _animationDuration = Duration.zero;
        });
      });
    }
  }

  setOpacity() {
    final double tmp = _positionYDelta < 0 ? 1 - ((_positionYDelta / 1000) * -1) : 1 - (_positionYDelta / 1000);
    debugPrint(tmp.toString());
    if (tmp > 1) {
      _opacity = 1;
    } else if (tmp < 0) {
      _opacity = 0;
    } else {
      _opacity = tmp;
    }

    if (_positionYDelta > _disposeLimit || _positionYDelta < -_disposeLimit) {
      _opacity = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPosition = 0 + max(_positionYDelta, -_positionYDelta) / 15;
    return Hero(
      tag: widget.tag,
      child: Scaffold(
        backgroundColor: widget.backgroundIsTransparent ? Colors.transparent : widget.backgroundColor,
        body: Container(
          color: widget.backgroundColor.withAlpha((_opacity * 255).toInt()),
          constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: _animationDuration,
                curve: Curves.fastOutSlowIn,
                top: 0 + _positionYDelta,
                bottom: 0 - _positionYDelta,
                left: horizontalPosition,
                right: horizontalPosition,
                child: InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  panEnabled: false,
                  child: widget.disableSwipeToDismiss
                      ? ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(40)), clipBehavior: Clip.hardEdge, child: widget.child)
                      : KeymotionGestureDetector(
                          onStart: (details) => _dragStart(details),
                          onUpdate: (details) => _dragUpdate(details),
                          onEnd: (details) => _dragEnd(details),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
                            clipBehavior: Clip.hardEdge,
                            child: widget.child,
                          ),
                        ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 30, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)), color: Color(0xff222222)),
                      child: const Center(child: Icon(Icons.close, color: Colors.grey)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KeymotionGestureDetector extends StatelessWidget {
  /// @macro
  const KeymotionGestureDetector({super.key, required this.child, this.onUpdate, this.onEnd, this.onStart});

  final Widget child;
  final GestureDragUpdateCallback? onUpdate;
  final GestureDragEndCallback? onEnd;
  final GestureDragStartCallback? onStart;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        VerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer()
            ..onStart = onStart
            ..onUpdate = onUpdate
            ..onEnd = onEnd,
          (instance) {},
        ),
        // DoubleTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
        //   () => DoubleTapGestureRecognizer()..onDoubleTap = onDoubleTap,
        //   (instance) {},
        // )
      },
      child: child,
    );
  }
}

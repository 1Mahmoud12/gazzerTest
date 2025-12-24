import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/features/share/presentation/share_service.dart';
import 'package:gazzer/main.dart';
import 'package:go_router/go_router.dart';

class DeepLinkService extends WidgetsBindingObserver {
  static final DeepLinkService _instance = DeepLinkService._internal();

  factory DeepLinkService() => _instance;

  DeepLinkService._internal();

  final AppLinks _appLinks = AppLinks();
  final ShareService _shareService = ShareService();
  StreamSubscription<Uri>? _linkSubscription;
  StreamSubscription<Uri>? _uriLinkSubscription;
  Uri? _pendingUri;
  bool _isAppResumed = true;
  bool _hasProcessedPendingUri = false;

  /// Initialize deep link listener
  void initialize() {
    // Register as lifecycle observer
    WidgetsBinding.instance.addObserver(this);

    // Listen to app links when app is already open
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        _handleDeepLink(uri);
      },
      onError: (Object err) {
        debugPrint('Deep link error: $err');
      },
    );

    // Listen to app links when app is opened from terminated state
    _appLinks.getInitialLink().then((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });

    // Listen to URI links (for custom schemes)
    _uriLinkSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        _handleDeepLink(uri);
      },
      onError: (Object err) {
        debugPrint('URI link error: $err');
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final wasResumed = _isAppResumed;
    _isAppResumed = state == AppLifecycleState.resumed;

    // Only process pending URI if:
    // 1. App just transitioned from background to resumed (not already resumed)
    // 2. We have a pending URI from a deep link
    // 3. We haven't already processed this pending URI
    if (!wasResumed &&
        _isAppResumed &&
        _pendingUri != null &&
        !_hasProcessedPendingUri) {
      debugPrint(
        'App resumed from background, processing pending deep link: $_pendingUri',
      );
      final uri = _pendingUri!;
      _pendingUri = null;
      _hasProcessedPendingUri = true;

      // Wait a bit for the app to fully resume
      Future.delayed(const Duration(milliseconds: 300), () {
        _navigateToRoute(uri);
      });
    }
  }

  /// Handle deep link navigation
  void _handleDeepLink(Uri uri) {
    debugPrint('Deep link received: $uri');
    debugPrint('App resumed state: $_isAppResumed');

    // Reset the processed flag when a new deep link arrives
    _hasProcessedPendingUri = false;

    // If app is not resumed (in background), store the URI and wait for resume
    if (!_isAppResumed) {
      debugPrint('App is in background, storing URI for later navigation');
      _pendingUri = uri;
      return;
    }

    final context = AppNavigator.mainKey.currentContext;
    if (context == null) {
      debugPrint(
        'Context not available, storing URI and will retry when context is ready',
      );
      _pendingUri = uri;
      // Retry after a delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_pendingUri != null && _isAppResumed && !_hasProcessedPendingUri) {
          _hasProcessedPendingUri = true;
          final uriToProcess = _pendingUri!;
          _pendingUri = null;
          _navigateToRoute(uriToProcess);
        }
      });
      return;
    }

    // App is resumed and context is available, navigate immediately
    _navigateToRoute(uri);
  }

  /// Navigate to the appropriate route based on the deep link
  void _navigateToRoute(Uri uri) {
    final context = AppNavigator.mainKey.currentContext;
    if (context == null) {
      debugPrint('Context still not available');
      return;
    }

    try {
      // Extract path from URI - handle both custom schemes and HTTP/HTTPS URLs
      String path;
      if (uri.scheme == 'gazzar' || uri.scheme == 'gazzer') {
        // Custom scheme: gazzar://invite?ref=CODE
        path = uri.path.isEmpty
            ? uri.toString().replaceAll('${uri.scheme}://', '')
            : uri.path;
      } else {
        // HTTP/HTTPS URL: https://tkgazzer.com/invite?ref=CODE
        path = uri.path;
      }

      final queryParams = uri.queryParameters;

      debugPrint('Navigating to: $path with params: $queryParams');
      debugPrint('Full URI: $uri');

      // Handle different deep link patterns
      if (path.startsWith('share') || path.startsWith('/share')) {
        // Handle share links: /share?token=TOKEN&type=TYPE
        final token = queryParams['token'];
        if (token != null && token.isNotEmpty) {
          logger.d('Opening share link with token: $token');
          _shareService.handleShareLink(context, token);
        } else {
          context.go('/');
        }
      } else if (path.startsWith('invite') || path.startsWith('/invite')) {
        // Handle invite links: /invite?ref=CODE
        final refCode = queryParams['ref'];
        if (refCode != null) {
          logger.d('Register with refCode: $refCode');

          // Navigate to register screen with referral code as query parameter
          // RegisterScreen reads from uri.queryParameters['ref']
          context.go('/register?ref=$refCode');
        } else {
          context.go('/register');
        }
      } else if (path.startsWith('/product') || path.startsWith('/pr')) {
        // Handle product links
        final productId = queryParams['id'] ?? path.split('/').last;
        if (productId.isNotEmpty) {
          context.push('/product/$productId');
        } else {
          context.go('/');
        }
      } else if (path.startsWith('/category') || path.startsWith('/ca')) {
        // Handle category links
        final categoryId = queryParams['id'] ?? path.split('/').last;
        if (categoryId.isNotEmpty) {
          context.push('/category/$categoryId');
        } else {
          context.go('/');
        }
      } else if (path.startsWith('/store')) {
        // Handle store links
        final storeId = queryParams['id'] ?? path.split('/').last;
        if (storeId.isNotEmpty) {
          context.push('/store/$storeId');
        } else {
          context.go('/');
        }
      } else if (path.isNotEmpty && path != '/') {
        // Try to navigate to the path directly
        context.push(path);
      } else {
        // Default to home
        context.go('/');
      }
    } catch (e) {
      debugPrint('Error navigating from deep link: $e');
      // Fallback to home on error
      context.go('/');
    }
  }

  /// Get the initial link when app is opened from terminated state
  Future<Uri?> getInitialLink() async {
    return await _appLinks.getInitialLink();
  }

  /// Get the latest link
  Future<Uri?> getLatestLink() async {
    return await _appLinks.getLatestLink();
  }

  /// Dispose resources
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _linkSubscription?.cancel();
    _uriLinkSubscription?.cancel();
    _pendingUri = null;
    _hasProcessedPendingUri = false;
  }
}

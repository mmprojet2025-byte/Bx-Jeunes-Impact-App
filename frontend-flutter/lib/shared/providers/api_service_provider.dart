import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_service.dart';

/// Global navigator key used by ApiService for navigation-triggered refresh flows.
///
/// Attach this key to your app's [MaterialApp.router] or [MaterialApp]
/// if you want refresh failures to be able to navigate automatically.
final apiServiceNavigatorKey = GlobalKey<NavigatorState>();

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(navigatorKey: apiServiceNavigatorKey);
});

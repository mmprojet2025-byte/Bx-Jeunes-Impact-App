import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = StreamProvider<List<ConnectivityResult>>((_) =>
    Connectivity().onConnectivityChanged);

/// Convenience provider — true if at least one connection is available.
final isOnlineProvider = Provider<bool>((ref) {
  final result = ref.watch(connectivityProvider).valueOrNull;
  if (result == null) return true; // assume online until known
  return result.any((r) => r != ConnectivityResult.none);
});

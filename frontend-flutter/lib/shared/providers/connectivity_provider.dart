import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final connectivityProvider = StreamProvider<ConnectivityResult>((_) {
  return Connectivity().onConnectivityChanged;
});
 
final isOnlineProvider = Provider<bool>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  return connectivity.maybeWhen(
    data: (result) => result != ConnectivityResult.none,
    orElse: () => true,
  );
});

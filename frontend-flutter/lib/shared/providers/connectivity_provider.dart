import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final connectivityProvider = StreamProvider<ConnectivityResult>((_) =>
    Connectivity().onConnectivityChanged);
 
final isOnlineProvider = Provider<bool>((ref) =>
    ref.watch(connectivityProvider).maybeWhen(
      data: (r) => r != ConnectivityResult.none, orElse: () => true));
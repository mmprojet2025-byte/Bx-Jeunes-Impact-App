import 'package:flutter/material.dart';
import '../../shared/services/secure_storage_service.dart';
import 'route_names.dart';
 
/// Wrap any screen that requires authentication.
/// Redirects to login if no access token found.
class AuthGuard extends StatefulWidget {
  final Widget child;
  const AuthGuard({super.key, required this.child});
 
  @override
  State<AuthGuard> createState() => _AuthGuardState();
}
 
class _AuthGuardState extends State<AuthGuard> {
  @override
  void initState() {
    super.initState();
    _check();
  }
 
  Future<void> _check() async {
    final token = await SecureStorageService.getAccessToken();
    if (token == null && mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.login, (_) => false);
    }
  }
 
  @override
  Widget build(BuildContext context) => widget.child;
}

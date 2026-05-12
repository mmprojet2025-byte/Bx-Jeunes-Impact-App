import 'package:flutter/material.dart';
 
import 'core/theme/app_theme.dart';
import 'core/router/route_names.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/dashboard/presentation/screens/home_screen.dart';
 
void main() {
  runApp(const BxJeunesApp());
}
 
class BxJeunesApp extends StatelessWidget {
  const BxJeunesApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bx-Jeunes Impact',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: RouteNames.login,
      routes: {
        RouteNames.login: (_) => const LoginScreen(),
        RouteNames.home:  (_) => const HomeScreen(),
      },
    );
  }
}
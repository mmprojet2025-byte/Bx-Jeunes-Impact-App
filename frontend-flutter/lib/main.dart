import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import 'app.dart';
import 'core/router/route_names.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/dashboard/presentation/screens/home_screen.dart';

void main() {
  //Initialiser les bindings Flutter avant tout appel plugin
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: BxJeunesApp(),
    ),
  );
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

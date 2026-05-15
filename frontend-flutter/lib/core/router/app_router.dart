import 'package:flutter/material.dart';
 
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/dashboard/presentation/screens/home_screen.dart';
import '../../features/activities/presentation/screens/activity_list_screen.dart';
import '../../features/activities/presentation/screens/activity_details_screen.dart';
import '../../features/activities/presentation/screens/activity_form_screen.dart';
import '../../features/activities/presentation/screens/attendance_screen.dart';
import '../../features/projects/presentation/screens/project_list_screen.dart';
import '../../features/projects/presentation/screens/project_detail_screen.dart';
import '../../features/projects/presentation/screens/project_form_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../../features/profile/presentation/screens/terms_of_services_screen.dart';
import 'route_names.dart';
 
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return _fade(const LoginScreen());
      case RouteNames.register:
        return _slide(const RegisterScreen());
      case RouteNames.forgotPassword:
        return _slide(const ForgotPasswordScreen());
      case RouteNames.home:
        return _fade(const HomeScreen());
      case RouteNames.activities:
        return _slide(const ActivityListScreen());
      case RouteNames.activityForm:
        return _slide(const ActivityFormScreen());
      case RouteNames.projects:
        return _slide(const ProjectListScreen());
      case RouteNames.projectForm:
        return _slide(const ProjectFormScreen());
      case RouteNames.profile:
        return _slide(const ProfileScreen());
      case RouteNames.editProfile:
        return _slide(const EditProfileScreen());
      case RouteNames.settings:
        return _slide(const SettingsScreen());
      case RouteNames.changePassword:
        return _slide(const ChangePasswordScreen());
      case RouteNames.privacyPolicy:
        return _slide(const PrivacyPolicyScreen());
      case RouteNames.termsOfService:
        return _slide(const TermsOfServicesScreen());
      default:
        return _fade(const LoginScreen());
    }
  }
 
  static PageRoute _fade(Widget page) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      );
 
  static PageRoute _slide(Widget page) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) => SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      );
}

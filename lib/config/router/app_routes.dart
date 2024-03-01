import 'package:crimson_cycle/features/auth/presentation/view/login_view.dart';
import 'package:crimson_cycle/features/auth/presentation/view/register_view.dart';
import 'package:crimson_cycle/features/bottom_view/cart_view.dart';
import 'package:crimson_cycle/features/bottom_view/doctor_consult.dart';
import 'package:crimson_cycle/features/bottom_view/profile.dart';
import 'package:crimson_cycle/features/dashboard/presentation/view/article_view.dart';
import 'package:crimson_cycle/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:crimson_cycle/features/dashboard/presentation/view/period_graph_page.dart';
import 'package:crimson_cycle/features/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dash';
  static const String splashRoute = '/splash';
  static const String drawerRoute = '/drawer';
  static const String healthRoute = '/health';
  static const String docRoute = '/doc';
  static const String cartRoute = '/buy';
  static const String articleRoute = '/article';
  static const String graphRoute = "/graph";

  static const String profileRoute = '/profile';
  static getApplicationRoute() {
    return {
      dashboardRoute: (context) => const DashboardView(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      splashRoute: (context) => const SplashView(),
      // healthRoute: (context) => const HealthInfoView(),
      docRoute: (context) => const DoctorView(),
      cartRoute: (context) => const CartView(),
      profileRoute: (context) => const ProfileView(),
      articleRoute: (context) => const ArticleView(),
      graphRoute: (context) => const PeriodGraphPage(),
    };
  }
}

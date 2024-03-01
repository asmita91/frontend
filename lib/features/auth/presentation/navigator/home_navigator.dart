import 'package:crimson_cycle/config/router/app_routes.dart';
import 'package:crimson_cycle/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// final homeNavigatorProvider = Provider(
//   (ref) => HomeNavigator(),
// );

// class HomeNavigator with LoginRoute {
//   @override
//   late BuildContext context;
// }

// mixin HomeRoute {
//   openHomeScreen() {
//     Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
//   }

//   BuildContext get context;
// }


final homeNavigatorProvider = Provider((ref) => HomeNavigator());

class HomeNavigator with LoginRoute {
  void openHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.dashboardRoute);
  }
  
  @override
  // TODO: implement context
  BuildContext get context => throw UnimplementedError();
}


mixin HomeRoute {
  void openHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.dashboardRoute);
  }
   void openLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.loginRoute);
  }
}

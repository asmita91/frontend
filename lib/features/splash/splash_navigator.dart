import 'package:crimson_cycle/config/router/app_routes.dart';
import 'package:crimson_cycle/features/auth/presentation/navigator/home_navigator.dart';
import 'package:crimson_cycle/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final splashNavigatorProvider = Provider((ref) => SplashNavigator());

// Go from splash to login
class SplashNavigator with LoginRoute, HomeRoute {
  @override
  late BuildContext context;
}

// mixin : used when we want to use the properties of another class
//without extending it
mixin SplashRoute {
  openSplashScreen() {
    Navigator.pushNamed(context, AppRoute.splashRoute);
  }

  // this context is not initialized here
  // Who ever will call this mixin will have to initialize it
  BuildContext get context;
}

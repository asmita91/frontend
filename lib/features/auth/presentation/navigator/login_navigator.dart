import 'package:crimson_cycle/config/router/app_routes.dart';
import 'package:crimson_cycle/features/auth/presentation/navigator/home_navigator.dart';
import 'package:crimson_cycle/features/auth/presentation/navigator/register_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNavigatorProvider = Provider((ref) => LoginNaviator());

// Go from login to register
class LoginNaviator with RegisterRoute, HomeRoute {
  @override
  late BuildContext context;
}

mixin LoginRoute {
  openLoginScreen(BuildContext context) {
    Navigator.popAndPushNamed(context, AppRoute.loginRoute);
  }

  BuildContext get context;
}

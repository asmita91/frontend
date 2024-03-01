import 'package:crimson_cycle/config/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerNavigatorProvider = Provider((ref) => RegisterNavigator());

class RegisterNavigator {
  void openRegisterScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.registerRoute);
  }
}

mixin RegisterRoute {
  void openRegisterScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.registerRoute);
  }
}

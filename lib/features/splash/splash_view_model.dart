import 'package:crimson_cycle/features/splash/splash_navigator.dart';
import 'package:crimson_cycle/config/router/app_routes.dart';
import 'package:crimson_cycle/core/shared_prefs/user_shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
      ref.read(splashNavigatorProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs userSharedPrefs;
  final SplashNavigator splashNavigator;

  SplashViewModel(
    this.userSharedPrefs,
    this.splashNavigator,
  ) : super(null);

  init(BuildContext context) async {
    final data = await userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) {
      if (token != null) {
        bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
          Navigator.popAndPushNamed(context, AppRoute.loginRoute);
        } else {
          Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
        }
      } else {
        Navigator.popAndPushNamed(context, AppRoute.loginRoute);
      }
    });
  }

  bool isValidToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // 10 digit
    int expirationTimestamp = decodedToken['exp'];
    // 13
    final currentDate = DateTime.now().millisecondsSinceEpoch;
    return currentDate > expirationTimestamp * 1000;
  }
}

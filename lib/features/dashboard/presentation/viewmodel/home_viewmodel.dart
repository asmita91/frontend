
import 'package:crimson_cycle/core/shared_prefs/user_shared_prefs.dart';
import 'package:crimson_cycle/features/auth/presentation/navigator/home_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, bool>(
  (ref) => HomeViewModel(
    ref.read(userSharedPrefsProvider),
    ref.read(homeNavigatorProvider),
  ),
);

class HomeViewModel extends StateNotifier<bool> {
  final UserSharedPrefs _userSharedPrefs;
  final HomeNavigator homeNavigator;

  HomeViewModel(
    this._userSharedPrefs,
    this.homeNavigator,
  ) : super(false);

  Future<void> logout(BuildContext context) async {
    state = true;

    await _userSharedPrefs.deleteUserToken();
    Future.delayed(const Duration(milliseconds: 2000), () {
      state = false;

      homeNavigator.openLoginScreen(context);
    });
  }

  void openLoginScreen(BuildContext context) {
    homeNavigator.openLoginScreen(context);
  }
  
}

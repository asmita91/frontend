import 'dart:io';

import 'package:crimson_cycle/config/router/app_routes.dart';
import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
import 'package:crimson_cycle/features/auth/domain/use_case/login_usecase.dart';
import 'package:crimson_cycle/features/auth/domain/use_case/register_usecase.dart';
import 'package:crimson_cycle/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:crimson_cycle/features/auth/presentation/navigator/login_navigator.dart';
import 'package:crimson_cycle/features/auth/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(registerUseCaseProvider),
    ref.read(loginUseCaseProvider),
    ref.read(uploadImageUseCaseProvider),
    ref.read(loginNavigatorProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final UploadImageUseCase _uploadImageUsecase;
  final LoginNaviator loginNavigator;

  AuthViewModel(
    this._registerUseCase,
    this._loginUseCase,
    this._uploadImageUsecase,
    this.loginNavigator,
  ) : super(AuthState.initial());

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _uploadImageUsecase.uploadProfilePicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          imageName: imageName,
        );
      },
    );
  }

  Future<void> registerUser(AuthEntity entity) async {
    state = state.copyWith(isLoading: true);
    final result = await _registerUseCase.registerUser(entity);
    state = state.copyWith(isLoading: false);
    result.fold(
      (failure) => state = state.copyWith(error: failure.error),
      (success) => state = state.copyWith(isLoading: false, showMessage: true),
    );
  }

  //Login
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await _loginUseCase.loginUser(email, password);
    state = state.copyWith(isLoading: false);
    // print(result);

    result.fold(
      (failure) {
        state = state.copyWith(
          error: null,
          showMessage: true,
          isLoading: false,
        );
        // showMySnackBar(message: failure.error, context: context, color: appRed);
      },
      (success) {
        state =
            state.copyWith(isLoading: false, showMessage: true, error: null);
        Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
        // showMySnackBar(message: success, context: context, color: appCOlor);
      },
    );
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      imageName: null,
      showMessage: false,
    );
  }

  resetState() {
    state = state.copyWith(isLoading: false, error: null, imageName: null);
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }

  openHomeScreen(BuildContext context) {
    loginNavigator.openHomeScreen(context);
  }
}

import 'package:crimson_cycle/features/auth/domain/use_case/login_usecase.dart';
import 'package:crimson_cycle/features/auth/domain/use_case/register_usecase.dart';
import 'package:crimson_cycle/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:crimson_cycle/features/auth/presentation/navigator/login_navigator.dart';
import 'package:crimson_cycle/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_unit_test.mocks.dart';

@GenerateNiceMocks([
  //yiniharu bhitra vako func lai mock garna
  MockSpec<LoginUseCase>(),
  MockSpec<BuildContext>(),
  MockSpec<RegisterUseCase>(),
  MockSpec<UploadImageUseCase>(),
  MockSpec<LoginNaviator>()
])
void main() {
  late LoginUseCase mockLoginUseCase;
  late RegisterUseCase mockRegisterUseCase;
  late UploadImageUseCase mockUploadUseCase;
  late BuildContext context;
  late LoginNaviator mockLoginNavigator;
  // yo chai providerscope ko satta ma use vako for state management
  late ProviderContainer container;

  setUpAll(() {
    mockLoginUseCase = MockLoginUseCase();
    context = MockBuildContext();
    mockRegisterUseCase = MockRegisterUseCase();
    mockUploadUseCase = MockUploadImageUseCase();
    mockLoginNavigator = MockLoginNaviator();
    context = MockBuildContext();
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith((ref) => AuthViewModel(
          mockRegisterUseCase,
          mockLoginUseCase,
          mockUploadUseCase,
          mockLoginNavigator))
    ]);
  });

  test("check for initial state", () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.showMessage, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  // test('login test with valid email and pasword', () async {
  //   when(mockLoginUseCase.loginUser("asmita@gmail.com", "asmita123"))
  //       .thenAnswer((_) => Future.value(Right(true)));

  //   await container
  //       .read(authViewModelProvider.notifier)
  //       .loginUser("asmita@gmail.com", "asmita123", context);

  //   final authState = container.read(authViewModelProvider);
  //   expect(authState.error, isNull);
  // });

  // tearDownAll(() {
  //   container.dispose();
  // });
}

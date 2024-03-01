import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
import 'package:crimson_cycle/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(ref.read(authRepositoryProvider)),
);

class LoginUseCase {
  final IAuthRepository _authRepository;

  LoginUseCase(this._authRepository);

 
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    return await _authRepository.loginUser(email, password);
  }
  
}

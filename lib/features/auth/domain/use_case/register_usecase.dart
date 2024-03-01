import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
import 'package:crimson_cycle/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerUseCaseProvider = Provider.autoDispose<RegisterUseCase>(
  (ref) => RegisterUseCase(ref.read(authRepositoryProvider)),
);

class RegisterUseCase {
  final IAuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerUser(AuthEntity entity) async {
    return await _authRepository.registerUser(entity);
  }
  
}

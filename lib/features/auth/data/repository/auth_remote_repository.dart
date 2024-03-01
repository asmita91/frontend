import 'dart:io';

import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
import 'package:crimson_cycle/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final authRemoteRepositoryProvider = Provider.autoDispose<IAuthRepository>(
  (ref) => AuthRemoteRepository(ref.read(authRemoteDataSourceProvider)),
);

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  // @override
  // Future<Either<Failure, bool>> loginStudent(String username, String password) {
  //   // TODO: implement loginStudent
  //   return _authRemoteDataSource.loginStudent(username, password);
  // }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return _authRemoteDataSource.registerUser(user);
  }
  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    final result = await _authRemoteDataSource.loginUser(email, password);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
  @override
  Future<Either<Failure, String>> forgotPassword(
      String email) async {
    final result = await _authRemoteDataSource.forgotPassword(email);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
  

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return _authRemoteDataSource.uploadProfilePicture(file);
  }
}

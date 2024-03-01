import 'dart:io';

import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/auth/data/repository/auth_remote_repository.dart';
import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authRepositoryProvider = Provider<IAuthRepository>(
  (ref) => ref.read(authRemoteRepositoryProvider),
);

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user);
  Future<Either<Failure, String>> loginUser(String email, String password);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
}

// import 'dart:io';

// import 'package:crimson_cycle/core/failure/failure.dart';
// import 'package:crimson_cycle/features/auth/data/data_source/auth_local_data_source.dart';
// import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
// import 'package:crimson_cycle/features/auth/domain/repository/auth_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';


// final authLocalRepositoryProvider = Provider.autoDispose<IAuthRepository>(
//   (ref) => AuthLocalRepository(ref.read(authLocalDataSourceProvider)),
// );
// class AuthLocalRepository implements IAuthRepository {
//   final AuthLocalDataSource _authLocalDataSource;

//   AuthLocalRepository(this._authLocalDataSource);

//   @override
//   Future<Either<Failure, bool>> loginStudent(String username, String password) {
//     return _authLocalDataSource.loginStudent(username, password);
//   }

//   @override
//   Future<Either<Failure, bool>> registerStudent(AuthEntity student) {
//     return _authLocalDataSource.registerStudent(student);
//   }

//   @override
//   Future<Either<Failure, String>> uploadProfilePicture(File file) async {
//     return const Right("");
//   }
// }

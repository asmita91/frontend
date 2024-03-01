import 'dart:io';

import 'package:crimson_cycle/config/constants/api_endpoint.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/core/network/http_service.dart';
import 'package:crimson_cycle/core/shared_prefs/user_shared_prefs.dart';
import 'package:crimson_cycle/features/auth/data/model/auth_api_model.dart';
import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider.autoDispose<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
      ref.read(httpServiceProvider), ref.read(userSharedPrefsProvider)),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource(this.dio, this.userSharedPrefs);

// Upload image using multipart
  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      AuthApiModel apiModel = AuthApiModel.fromEntity(user);
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "image": apiModel.image,
          "email": apiModel.email,
          "lastName": apiModel.lastName,
          "firstName": apiModel.firstName,
          "password": apiModel.password,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return left(Failure(
          error: response.data["message"],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];
        // String userId = response.data["userId"];

        String token = response.data["token"];
        print("USER LOGIN RESPONSE::${response.data}");
        await userSharedPrefs.setUserToken(token);
        // await userSharedPrefs.setUserId(userId);

        await userSharedPrefs.setUser(response.data['userData']);

        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> forgotPassword(
    String email,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.forgotPassword,
        data: {
          "email": email,
        },
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];
        print("USER LOGIN RESPONSE::${response.data}");

        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}

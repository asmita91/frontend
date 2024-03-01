import 'package:crimson_cycle/config/constants/api_endpoint.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/core/network/http_service.dart';
import 'package:crimson_cycle/core/shared_prefs/user_shared_prefs.dart';
import 'package:crimson_cycle/features/healthInfo/data/model/health_info_api_model.dart';
import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final healthInfoRemoteDataSourceProvider = Provider(
  (ref) => HealthInfoRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    healthInfoApiModel: ref.read(healthInfoApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class HealthInfoRemoteDataSource {
  final Dio dio;
  final HealthInfoApiModel healthInfoApiModel;
  final UserSharedPrefs userSharedPrefs;

  HealthInfoRemoteDataSource({
    required this.dio,
    required this.healthInfoApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addOrUpdateHealthInfo(
      HealthInfoEntity healthInfo, String userId) async {
    try {
      print("POST:::${ApiEndpoints.addUpdateHealth}");
      var response = await dio.post(
        ApiEndpoints.addUpdateHealth(userId),
        data: HealthInfoApiModel.fromEntity(healthInfo).toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assuming 200 for update, 201 for create
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'] ?? 'Unknown error',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, HealthInfoEntity>> getHealthInfo(String userId) async {
    try {
      var response = await dio.get(
        ApiEndpoints.getHealthInfoById(userId),
      );

      if (response.statusCode == 200) {
        HealthInfoEntity healthInfo =
            HealthInfoApiModel.fromJson(response.data).toEntity();
        return Right(healthInfo);
      } else {
        return Left(
          Failure(
            error: response.data['message'] ?? 'Unknown error',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }
}

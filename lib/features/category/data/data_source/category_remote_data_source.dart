import 'package:crimson_cycle/config/constants/api_endpoint.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/core/network/http_service.dart';
import 'package:crimson_cycle/core/shared_prefs/user_shared_prefs.dart';
import 'package:crimson_cycle/features/category/data/dto/get_all_category_dto.dart';
import 'package:crimson_cycle/features/category/data/model/category_api_model.dart';
import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../dto/get_all_students_by_batch.dart';

final categoryRemoteDataSourceProvider = Provider(
  (ref) => CategoryRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    categoryApiModel: ref.read(categoryApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    // authApiModel: ref.read(authApiModelProvider),
  ),
);

class CategoryRemoteDataSource {
  final Dio dio;
  final CategoryApiModel categoryApiModel;

  final UserSharedPrefs userSharedPrefs;

  CategoryRemoteDataSource({
    required this.dio,
    required this.categoryApiModel,
    // required this.authApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addCategory(CategoryEntity category) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createCategory,
        data: categoryApiModel.fromEntity(category).toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCategories);
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        GetAllCategoryDTO categoryAddDTO =
            GetAllCategoryDTO.fromJson(response.data);
        return Right(categoryApiModel.toEntityList(categoryAddDTO.category));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
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

  // // Get all students by batchId
  // Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
  //     String batchId) async {
  //   try {
  //     // get token
  //     String? token;
  //     await userSharedPrefs
  //         .getUserToken()
  //         .then((value) => value.fold((l) => null, (r) => token = r!));

  //     var response = await dio.get(ApiEndpoints.getStudentsByBatch + batchId,
  //         options: Options(
  //           headers: {
  //             'Authorization': 'Bearer $token',
  //           },
  //         ));
  //     if (response.statusCode == 201) {
  //       GetAllStudentsByBatchDTO getAllStudentDTO =
  //           GetAllStudentsByBatchDTO.fromJson(response.data);

  //       return Right(authApiModel.listFromJson(getAllStudentDTO.data));
  //     } else {
  //       return Left(
  //         Failure(
  //           error: response.statusMessage.toString(),
  //           statusCode: response.statusCode.toString(),
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return Left(
  //       Failure(
  //         error: e.error.toString(),
  //       ),
  //     );
  //   }
  // }

  Future<Either<Failure, bool>> deleteCategory(String categoryId) async {
    try {
      Response response = await dio.delete(
        ApiEndpoints.deleteCategoryById + categoryId,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiEndpoints.token}',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
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

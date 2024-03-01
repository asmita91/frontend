import 'package:crimson_cycle/config/constants/api_endpoint.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/core/network/http_service.dart';
import 'package:crimson_cycle/core/shared_prefs/user_shared_prefs.dart';
import 'package:crimson_cycle/features/category/data/model/category_api_model.dart';
import 'package:crimson_cycle/features/product/data/dto/get_all_product_dto.dart';
import 'package:crimson_cycle/features/product/data/model/product_api_model.dart';
import 'package:crimson_cycle/features/product/domain/entity/product_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteDataSourceProvider = Provider(
  (ref) => ProductRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    productApiModel: ref.read(productApiModelProvider),
    categoryApiModel: ref.read(categoryApiModelProvider),
  ),
);

class ProductRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final ProductApiModel productApiModel;
  final CategoryApiModel categoryApiModel;
  ProductRemoteDataSource({
    required this.userSharedPrefs,
    required this.dio,
    required this.productApiModel,
    required this.categoryApiModel,
  });

  Future<Either<Failure, bool>> addProduct(ProductEntity product) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.createProduct,
        data:
            //  {

            //   "productName": "Sample Product",
            //   "productPrice": 99.99,
            //   "productDescription": "This is a sample product description.",
            //   "category":
            //       "65d8a8b12d62fceb70117b19", // Replace with a valid ObjectId from your Category collection
            //   "createdAt":
            //       "2024-01-01T00:00:00.000Z" // Optional: This will be set to the current date/time by default
            // }

            {
          "productName": product.productName,
          "productDescription": product.productDescription,
          "productPrice": product.productPrice,
          // "productImageUrl": product.productImageUrl,
          "createdAt": product.createdAt!.toIso8601String(),
          "category": product.category?.categoryId.toString(),
        },
      );
      print("STATUDE CODE::${response.statusCode}");
      if (response.statusCode == 201) {
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
      print("CATCH ERROR::${e.toString()}");
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
  //   try {
  //     var response = await dio.get(ApiEndpoints.allProductPagination);
  //     if (response.statusCode == 200) {
  //       GetAllProductDTO productAddDTO =
  //           GetAllProductDTO.fromJson(response.data);
  //       return Right(productApiModel.toEntityList(productAddDTO.products));
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
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      var response = await dio.get(ApiEndpoints.allProductPagination);
      if (response.statusCode == 200) {
        GetAllProductDTO productAddDTO =
            GetAllProductDTO.fromJson(response.data);
        return Right(productApiModel.toEntityList(productAddDTO.products));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  Future<Either<Failure, bool>> deleteProduct(String productId) async {
    try {
      Response response = await dio.delete(
        ApiEndpoints.deleteProduct + productId,
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
//   Future<Either<Failure, bool>> updateProduct(String productId, ProductEntity product) async {
//   try {
//     var productData = productApiModel.fromEntity(product).toJson();

//     String updateEndpoint = '${ApiEndpoints.updateProduct}/$productId';

//     Response response = await dio.put(
//       updateEndpoint,
//       data: productData,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer ${await userSharedPrefs.getUserToken()}',
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       return const Right(true);
//     } else {
//       return Left(
//         Failure(
//           error: response.data["message"] ?? "Unknown error during product update.",
//           statusCode: response.statusCode.toString(),
//         ),
//       );
//     }
//   } on DioException catch (e) {
//     return Left(
//       Failure(
//         error: e.message.toString(),
//         statusCode: e.response?.statusCode.toString() ?? '0',
//       ),
//     );
//   } catch (e) {
//     // Generic error handling
//     return Left(Failure(error: e.toString()));
//   }
// }
}

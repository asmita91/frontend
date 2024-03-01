import 'package:crimson_cycle/config/constants/api_endpoint.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/core/network/http_service.dart';
import 'package:crimson_cycle/features/order/data/dto/get_all_order_dto.dart';
import 'package:crimson_cycle/features/order/data/model/order_api_model.dart';
import 'package:crimson_cycle/features/order/domain/entity/order_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final orderRemoteDataSourceProvider =
    Provider.autoDispose<OrderRemoteDataSource>(
  (ref) => OrderRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class OrderRemoteDataSource {
  final Dio dio;
  OrderRemoteDataSource({required this.dio});

  Future<Either<Failure, String>> addOrder(OrderEntity order) async {
    try {
      OrderAPIModel orderAPIModel = OrderAPIModel.fromEntity(order);
      var response = await dio.post(ApiEndpoints.createOrder,
          data: orderAPIModel.toJson());

      if (response.statusCode == 201) {
        print("Response Data: ${response.data}");

        return Right(response.data["message"]);
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
      
    }
  }

  Future<Either<Failure, List<OrderEntity>>> getAllOrder(String userId) async {
    try {
      var response = await dio.get(ApiEndpoints.getOrders + userId);
      if (response.statusCode == 200) {
        GetAllOrderDTO getAllOrderDTO = GetAllOrderDTO.fromJson(response.data);
        List<OrderEntity> orderList = getAllOrderDTO.orders
            .map(
              (order) => OrderAPIModel.toEntity(order),
            )
            .toList();
        print(getAllOrderDTO);
        return Right(orderList);
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
}

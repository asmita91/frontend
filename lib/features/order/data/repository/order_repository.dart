import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/order/data/data_source/order_remote_repository.dart';
import 'package:crimson_cycle/features/order/domain/entity/order_entity.dart';
import 'package:crimson_cycle/features/order/domain/repository/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderRemoteRepositoryProvider = Provider.autoDispose<IOrderRepository>(
  (ref) => OrderRemoteImpl(
    orderRemoteDataSource: ref.read(orderRemoteDataSourceProvider),
  ),
);

class OrderRemoteImpl extends IOrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRemoteImpl({required this.orderRemoteDataSource});

  @override
  Future<Either<Failure, String>> createOrder(OrderEntity order) async {
    final result = await orderRemoteDataSource.addOrder(order);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
  
   @override
  Future<Either<Failure, List<OrderEntity>>> getAllOrders(String userId) {
    return orderRemoteDataSource.getAllOrder(userId);
  }

}

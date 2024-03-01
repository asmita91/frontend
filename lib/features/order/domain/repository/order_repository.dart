import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/order/data/repository/order_repository.dart';
import 'package:crimson_cycle/features/order/domain/entity/order_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final orderRepositoryProvider = Provider.autoDispose<IOrderRepository>(
  (ref) => ref.read(orderRemoteRepositoryProvider),
);

abstract class IOrderRepository {
  Future<Either<Failure, String>> createOrder(OrderEntity order);
    Future<Either<Failure, List<OrderEntity>>> getAllOrders(String userId);

}

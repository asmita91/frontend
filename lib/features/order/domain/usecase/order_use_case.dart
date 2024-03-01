import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/core/shared_prefs/user_shared_prefs.dart';
import 'package:crimson_cycle/features/order/domain/entity/order_entity.dart';
import 'package:crimson_cycle/features/order/domain/repository/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final orderUseCaseProvider = Provider.autoDispose<OrderUseCase>(
  (ref) => OrderUseCase(
      ref.read(orderRepositoryProvider), ref.read(userSharedPrefsProvider)),
);

class OrderUseCase {
  final IOrderRepository _orderRepository;
  final UserSharedPrefs sharedPrefs;

  OrderUseCase(this._orderRepository, this.sharedPrefs);

  Future<Either<Failure, String>> createOrder(OrderEntity order) async {
    return await _orderRepository.createOrder(order);
  }

  Future<Either<Failure, List<OrderEntity>>> getAllOrders() async {
    final userData = await sharedPrefs.getUser();
    String? id = userData?['_id']?.toString() ?? '';

    final data = await _orderRepository.getAllOrders(id);
    return data.fold(
      (l) => Left(l),
      (r) async {
        print(r);
        return Right(r);
      },
    );
  }
}

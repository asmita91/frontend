import 'package:crimson_cycle/features/order/domain/entity/order_entity.dart';
import 'package:crimson_cycle/features/order/domain/usecase/order_use_case.dart';
import 'package:crimson_cycle/features/order/presentation/state/order_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, OrderState>(
  (ref) => OrderViewModel(ref.read(orderUseCaseProvider)),
);

class OrderViewModel extends StateNotifier<OrderState> {
  final OrderUseCase _read;

  OrderViewModel(this._read) : super(OrderState.initial()) {
    getOrders();
  }

  Future<void> createOrder(OrderEntity entity, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final result = await _read.createOrder(entity);
    state = state.copyWith(isLoading: false);

    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (success) {
        state = state.copyWith(successMessage: "Order successfully placed.");
      },
    );
  }

  Future<void> getOrders() async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await _read.getAllOrders();
      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false);
          print("Error fetching data: $failure");
        },
        (success) {
          state = state.copyWith(isLoading: false, orders: null);
          print("Data in viewModel of application list: $success");
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print("Error fetching data: $e");
    }
  }

  void resetState() {
    state = OrderState.initial();
    getOrders();
  }
}

import 'package:crimson_cycle/features/order/domain/entity/order_entity.dart';

class OrderState {
  final bool isLoading;
  final String? error;
  final String? successMessage;
  final List<OrderEntity> orders;

  OrderState({
    this.isLoading = false,
    this.error,
    this.successMessage,
    required this.orders,
  });

  OrderState copyWith({
    bool? isLoading,
    String? error,
    List<OrderEntity>? orders,
    String? successMessage,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  static OrderState initial() => OrderState(
        orders: [],
        isLoading: false,
      );
}

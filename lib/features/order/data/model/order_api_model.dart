import 'package:crimson_cycle/features/order/domain/entity/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_api_model.g.dart';

@JsonSerializable()
class OrderAPIModel {
  final List<OrderItemEntity>? items;
  final String? userId;
  final String? orderId;
  final String? status;

  OrderAPIModel({this.items, this.userId, this.orderId, this.status});

  factory OrderAPIModel.fromJson(Map<String, dynamic> json) {
    print(json['orderId']);

    var itemsfromjson = json['items'];

    return OrderAPIModel(
        status: json['status'],
        orderId: json['orderId'],
        items: List.from(itemsfromjson.map((i) => OrderItemEntity.fromJson(i))),
        userId: json['userId']);
  }
  Map<String, dynamic> toJson() => _$OrderAPIModelToJson(this);

  factory OrderAPIModel.fromEntity(OrderEntity entity) {
    return OrderAPIModel(
        items: entity.items,
        userId: entity.userId,
        orderId: entity.orderId,
        status: entity.status);
  }

  static OrderEntity toEntity(OrderAPIModel order) {
    return OrderEntity(
        items: order.items,
        userId: order.userId,
        orderId: order.orderId,
        status: order.status);
  }
}

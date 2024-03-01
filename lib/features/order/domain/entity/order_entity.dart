import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final List<OrderItemEntity>? items;
  final String? userId;
  final String? orderId;
  final String? status;

  const OrderEntity({this.items, this.userId, this.orderId, this.status});

  @override
  List<Object?> get props => [items, userId];

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] as List<dynamic>?;
    List<OrderItemEntity>? itemsList = itemsFromJson
        ?.map((itemJson) => OrderItemEntity.fromJson(itemJson))
        .toList();

    return OrderEntity(
        status: json['status'] as String?,
        items: itemsList,
        userId: json['userId'] as String?,
        orderId: json['orderId'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((item) => item.toJson()).toList(),
      'userId': userId,
      'orderId': orderId
    };
  }

  @override
  String toString() => 'OrderEntity(items: $items, userId: $userId)';
}

class OrderItemEntity extends Equatable {
  final String? productName;

  final String? category;
  final String? description;
  final String productId;
  final int quantity;
  final double? price;
  // Assuming you might want to include price per item

  const OrderItemEntity({
    required this.productId,
    required this.quantity,
    this.price,
    this.productName,
    this.category,
    this.description,
  });

  @override
  List<Object?> get props => [productId, quantity, price];

  factory OrderItemEntity.fromJson(Map<String, dynamic> json) {
    var quantity = json['quantity'];
    var price = json['productId']['productPrice'];

    return OrderItemEntity(
      productName: json['productId']['productName'],
      productId: json['productId']["_id"] as String,
      description: json['productId']['productDescription'],
      category: json['productId']['category']['name'],
      quantity: quantity as int,
      price: (double.tryParse(price) ?? 0) * quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}

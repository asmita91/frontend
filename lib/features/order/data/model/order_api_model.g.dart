// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAPIModel _$OrderAPIModelFromJson(Map<String, dynamic> json) =>
    OrderAPIModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['userId'] as String?,
      orderId: json['orderId'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrderAPIModelToJson(OrderAPIModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'userId': instance.userId,
      'orderId': instance.orderId,
      'status': instance.status,
    };

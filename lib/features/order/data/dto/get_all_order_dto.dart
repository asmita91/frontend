import 'package:crimson_cycle/features/order/data/model/order_api_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_all_order_dto.g.dart';

@JsonSerializable()
class GetAllOrderDTO{
  final bool success;
  // final int count;
  final List<OrderAPIModel> orders;

  GetAllOrderDTO({required this.success,
   required this.orders});

  factory GetAllOrderDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllOrderDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllOrderDTOToJson(this);
}
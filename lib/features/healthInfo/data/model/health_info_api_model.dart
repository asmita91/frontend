import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_info_api_model.g.dart';

final healthInfoApiModelProvider = Provider<HealthInfoApiModel>(
  (ref) => HealthInfoApiModel.empty(),
);

@JsonSerializable()
class HealthInfoApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final int age;
  final int height;
  final int weight;
  @JsonKey(name: 'lastPeriodDate')
  final DateTime lastPeriodDate;
  final int periodDays;
  final int periodInterval;
  @JsonKey(name: 'isRegularPeriod')
  final bool isRegularPeriod;
  @JsonKey(name: 'hasCramps')
  final bool hasCramps;

  const HealthInfoApiModel({
    this.id,
    this.userId,
    required this.age,
    required this.height,
    required this.weight,
    required this.lastPeriodDate,
    required this.periodDays,
    required this.periodInterval,
    required this.isRegularPeriod,
    required this.hasCramps,
  });

  HealthInfoApiModel.empty()
      : id = '',
        userId = '',
        age = 0,
        height = 0,
        weight = 0,
        lastPeriodDate = DateTime(1970, 1, 1),
        periodDays = 0,
        periodInterval = 0,
        isRegularPeriod = false,
        hasCramps = false;

  Map<String, dynamic> toJson() => _$HealthInfoApiModelToJson(this);

  factory HealthInfoApiModel.fromJson(Map<String, dynamic> json) =>
      _$HealthInfoApiModelFromJson(json);

  // Convert API Object to Entity
  HealthInfoEntity toEntity() => HealthInfoEntity(
        id: id,
        userId: userId!,
        age: age,
        height: height,
        weight: weight,
        lastPeriodDate: lastPeriodDate,
        periodDays: periodDays,
        periodInterval: periodInterval,
        isRegularPeriod: isRegularPeriod,
        hasCramps: hasCramps,
      );

  // Convert Entity to API Object
  static HealthInfoApiModel fromEntity(HealthInfoEntity entity) =>
      HealthInfoApiModel(
        id: entity.id ?? '',
        userId: entity.userId,
        age: entity.age,
        height: entity.height,
        weight: entity.weight,
        lastPeriodDate: entity.lastPeriodDate,
        periodDays: entity.periodDays,
        periodInterval: entity.periodInterval,
        isRegularPeriod: entity.isRegularPeriod,
        hasCramps: entity.hasCramps,
      );

  @override
  List<Object?> get props => [
        id,
        userId,
        age,
        height,
        weight,
        lastPeriodDate,
        periodDays,
        periodInterval,
        isRegularPeriod,
        hasCramps
      ];
}

import 'package:crimson_cycle/config/constants/hive_table_constant.dart';
import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'health_info_hive_model.g.dart';

final healthInfoHiveModelProvider = Provider(
  (ref) => HealthInfoHiveModel.empty(),
);

@HiveType(
    typeId: HiveTableConstant
        .healthInfoTableId) // Ensure this constant is unique and defined in HiveTableConstant
class HealthInfoHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final int height;

  @HiveField(3)
  final int weight;

  @HiveField(4)
  final DateTime lastPeriodDate;

  @HiveField(5)
  final int periodDays;

  @HiveField(6)
  final int periodInterval;

  @HiveField(7)
  final bool isRegularPeriod;

  @HiveField(8)
  final bool hasCramps;

  @HiveField(9)
  final String userId;

  HealthInfoHiveModel({
    String? id,
    required this.userId,
    required this.age,
    required this.height,
    required this.weight,
    required this.lastPeriodDate,
    required this.periodDays,
    required this.periodInterval,
    required this.isRegularPeriod,
    required this.hasCramps,
  }) : id = id ?? const Uuid().v4();

  // Empty constructor
  HealthInfoHiveModel.empty()
      : this(
          id: '',
          userId: '',
          age: 0,
          height: 0,
          weight: 0,
          lastPeriodDate: DateTime.now(),
          periodDays: 0,
          periodInterval: 0,
          isRegularPeriod: false,
          hasCramps: false,
        );

  // Convert Hive Model to Entity
  HealthInfoEntity toEntity() => HealthInfoEntity(
        id: id,
        userId: userId,
        age: age,
        height: height,
        weight: weight,
        lastPeriodDate: lastPeriodDate,
        periodDays: periodDays,
        periodInterval: periodInterval,
        isRegularPeriod: isRegularPeriod,
        hasCramps: hasCramps,
      );

  // Convert Entity to Hive Model
  static HealthInfoHiveModel fromEntity(HealthInfoEntity entity) =>
      HealthInfoHiveModel(
        id: entity.id,
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

  // Convert Hive Model List to Entity List
  static List<HealthInfoEntity> toEntityList(
          List<HealthInfoHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();
}

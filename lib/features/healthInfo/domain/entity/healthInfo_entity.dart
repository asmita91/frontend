import 'package:equatable/equatable.dart';

class HealthInfoEntity extends Equatable {
  final String? id;
  final String userId;
  final int age;
  final int height;
  final int weight;
  final DateTime lastPeriodDate;
  final int periodDays;
  final int periodInterval;
  final bool isRegularPeriod;
  final bool hasCramps;

  @override
  List<Object?> get props => [
        id,
        age,
        height,
        weight,
        lastPeriodDate,
        periodDays,
        periodInterval,
        isRegularPeriod,
        hasCramps,
      ];

  const HealthInfoEntity({
    this.id,
    required this.userId,
    required this.age,
    required this.height,
    required this.weight,
    required this.lastPeriodDate,
    required this.periodDays,
    required this.periodInterval,
    required this.isRegularPeriod,
    required this.hasCramps,
  });

  factory HealthInfoEntity.fromJson(Map<String, dynamic> json) =>
      HealthInfoEntity(
        id: json["_id"],
        userId: json['userId'],
        age: json["age"],
        height: json["height"],
        weight: json["weight"],
        lastPeriodDate: DateTime.parse(json["lastPeriodDate"]),
        periodDays: json["periodDays"],
        periodInterval: json["periodInterval"],
        isRegularPeriod: json["isRegularPeriod"],
        hasCramps: json["hasCramps"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId":userId,
        "age": age,
        "height": height,
        "weight": weight,
        "lastPeriodDate": lastPeriodDate.toIso8601String(),
        "periodDays": periodDays,
        "periodInterval": periodInterval,
        "isRegularPeriod": isRegularPeriod,
        "hasCramps": hasCramps,
      };
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_info_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthInfoApiModel _$HealthInfoApiModelFromJson(Map<String, dynamic> json) =>
    HealthInfoApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      age: json['age'] as int,
      height: json['height'] as int,
      weight: json['weight'] as int,
      lastPeriodDate: DateTime.parse(json['lastPeriodDate'] as String),
      periodDays: json['periodDays'] as int,
      periodInterval: json['periodInterval'] as int,
      isRegularPeriod: json['isRegularPeriod'] as bool,
      hasCramps: json['hasCramps'] as bool,
    );

Map<String, dynamic> _$HealthInfoApiModelToJson(HealthInfoApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
      'lastPeriodDate': instance.lastPeriodDate.toIso8601String(),
      'periodDays': instance.periodDays,
      'periodInterval': instance.periodInterval,
      'isRegularPeriod': instance.isRegularPeriod,
      'hasCramps': instance.hasCramps,
    };

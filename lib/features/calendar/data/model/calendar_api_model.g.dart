// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarApiModel _$CalendarApiModelFromJson(Map<String, dynamic> json) =>
    CalendarApiModel(
      calendarId: json['_id'] as String?,
      userId: json['userId'] as String,
      events: (json['events'] as List<dynamic>)
          .map((e) => EventApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CalendarApiModelToJson(CalendarApiModel instance) =>
    <String, dynamic>{
      '_id': instance.calendarId,
      'userId': instance.userId,
      'events': instance.events,
    };

EventApiModel _$EventApiModelFromJson(Map<String, dynamic> json) =>
    EventApiModel(
      type: json['type'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$EventApiModelToJson(EventApiModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'date': instance.date.toIso8601String(),
    };

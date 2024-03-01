import 'package:crimson_cycle/features/calendar/domain/entity/calendar_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_api_model.g.dart';

final calendarApiModelProvider = Provider<CalendarApiModel>(
  (ref) => const CalendarApiModel.empty(),
);

@JsonSerializable()
class CalendarApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? calendarId;
  final String userId;
  final List<EventApiModel> events;

  const CalendarApiModel({
    this.calendarId,
    required this.userId,
    required this.events,
  });

  const CalendarApiModel.empty()
      : calendarId = '',
        userId = '',
        events = const [];

  Map<String, dynamic> toJson() => _$CalendarApiModelToJson(this);

  factory CalendarApiModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarApiModelFromJson(json);

  CalendarEntity toEntity() => CalendarEntity(
        calendarId: calendarId,
        userId: userId,
        events: events.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [calendarId, userId, events];
}

@JsonSerializable()
class EventApiModel extends Equatable {
  final String type;
  final DateTime date;

  const EventApiModel({
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toJson() => _$EventApiModelToJson(this);

  factory EventApiModel.fromJson(Map<String, dynamic> json) =>
      _$EventApiModelFromJson(json);

  CalendarEventEntity toEntity() => CalendarEventEntity(
        type: type,
        date: date,
      );

  @override
  List<Object?> get props => [type, date];
}

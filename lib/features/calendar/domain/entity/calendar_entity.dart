import 'package:equatable/equatable.dart';

class CalendarEntity extends Equatable {
  final String? calendarId;
  final String userId;
  final List<CalendarEventEntity> events;

  const CalendarEntity({
    this.calendarId,
    required this.userId,
    required this.events,
  });

  @override
  List<Object?> get props => [calendarId, userId, events];

  factory CalendarEntity.fromJson(Map<String, dynamic> json) => CalendarEntity(
        calendarId: json['_id'],
        userId: json['userId'],
        events: (json['events'] as List<dynamic>)
            .map((e) => CalendarEventEntity.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': calendarId,
        'userId': userId,
        'events': events.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'CalendarEntity(calendarId: $calendarId, userId: $userId, events: $events)';
  }
}

class CalendarEventEntity extends Equatable {
  final String type;
  final DateTime date;

  const CalendarEventEntity({
    required this.type,
    required this.date,
  });

  @override
  List<Object?> get props => [type, date];

  factory CalendarEventEntity.fromJson(Map<String, dynamic> json) =>
      CalendarEventEntity(
        type: json['type'],
        date: DateTime.parse(json['date']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'date': date.toIso8601String(),
      };

  @override
  String toString() {
    return 'CalendarEventEntity(type: $type, date: $date)';
  }
}

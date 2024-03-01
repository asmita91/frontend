import 'package:crimson_cycle/features/calendar/domain/entity/calendar_entity.dart';

class CalendarState {
  final bool isLoading;
  final CalendarEntity?
      calendar; // Assuming a user has a single calendar entity
  final String? error;

  CalendarState({
    required this.isLoading,
    this.calendar,
    this.error,
  });

  factory CalendarState.initial() {
    return CalendarState(
      isLoading: false,
      calendar: null, // Initially, there might be no calendar data available
    );
  }

  CalendarState copyWith({
    bool? isLoading,
    CalendarEntity? calendar,
    String? error,
  }) {
    return CalendarState(
      isLoading: isLoading ?? this.isLoading,
      calendar: calendar ?? this.calendar,
      error: error ?? this.error,
    );
  }
}

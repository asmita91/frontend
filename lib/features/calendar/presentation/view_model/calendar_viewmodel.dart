import 'package:crimson_cycle/features/calendar/domain/usecase/calendar_usecase.dart';
import 'package:crimson_cycle/features/calendar/presentation/state/calendar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarViewModelProvider =
    StateNotifierProvider.family<CalendarViewModel, CalendarState, String>(
  (ref, userId) {
    return CalendarViewModel(ref.read(calendarUseCaseProvider), userId);
  },
);

class CalendarViewModel extends StateNotifier<CalendarState> {
  final CalendarUseCase calendarUseCase;
  final String userId;

  CalendarViewModel(this.calendarUseCase, this.userId)
      : super(CalendarState.initial()) {
    getUserCalendarEvents(userId);
  }

  void getUserCalendarEvents(String userId) async {
    state = state.copyWith(isLoading: true);
    var result = await calendarUseCase.getUserCalendarEvents(userId);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: null),
      (calendar) => state =
          state.copyWith(isLoading: false, calendar: calendar, error: null),
    );
  }

  // Additional methods for calendar management
}

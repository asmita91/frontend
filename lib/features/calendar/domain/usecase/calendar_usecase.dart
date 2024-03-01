import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/calendar/domain/entity/calendar_entity.dart';
import 'package:crimson_cycle/features/calendar/domain/repository/calendar_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarUseCaseProvider = Provider<CalendarUseCase>(
  (ref) => CalendarUseCase(
    calendarRepository: ref.watch(calendarRepositoryProvider),
  ),
);

class CalendarUseCase {
  final ICalendarRepository calendarRepository;

  CalendarUseCase({required this.calendarRepository});

  Future<Either<Failure, CalendarEntity>> getUserCalendarEvents(String userId) {
    return calendarRepository.getUserCalendarEvents(userId);
  }
}

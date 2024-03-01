import 'package:crimson_cycle/core/common/provider/network_provider.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/calendar/data/repository/calendar_remote_repo.dart';
import 'package:crimson_cycle/features/calendar/domain/entity/calendar_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarRepositoryProvider = Provider<ICalendarRepository>(
  (ref) {
    // Check for the internet connectivity
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repository
      return ref.watch(calendarRemoteRepoProvider);
    } else {
      // If internet is not available then return local repository
      return ref.watch(calendarRemoteRepoProvider);
    }
  },
);

abstract class ICalendarRepository {
  Future<Either<Failure, CalendarEntity>> getUserCalendarEvents(String userId);
}

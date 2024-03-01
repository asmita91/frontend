import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/calendar/data/data_source/calendar_remote_data_source.dart';
import 'package:crimson_cycle/features/calendar/data/model/calendar_api_model.dart';
import 'package:crimson_cycle/features/calendar/domain/entity/calendar_entity.dart';
import 'package:crimson_cycle/features/calendar/domain/repository/calendar_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarRemoteRepoProvider = Provider<ICalendarRepository>(
  (ref) => CalendarRemoteRepositoryImpl(
    calendarRemoteDataSource: ref.read(calendarRemoteDataSourceProvider),
  ),
);

class CalendarRemoteRepositoryImpl implements ICalendarRepository {
  final CalendarRemoteDataSource calendarRemoteDataSource;

  CalendarRemoteRepositoryImpl({required this.calendarRemoteDataSource});

  @override
  Future<Either<Failure, CalendarEntity>> getUserCalendarEvents(String userId) async {
    try {
      Either<Failure, CalendarApiModel> result = await calendarRemoteDataSource.getUserCalendarEvents(userId);
      return result.map((apiModel) => apiModel.toEntity()); // Convert CalendarApiModel to CalendarEntity
    } catch (error) {
      return Left(Failure(error: error.toString()));
    }
  }
}

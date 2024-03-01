import 'package:crimson_cycle/config/constants/api_endpoint.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/core/network/http_service.dart';
import 'package:crimson_cycle/features/calendar/data/model/calendar_api_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarRemoteDataSourceProvider = Provider<CalendarRemoteDataSource>(
  (ref) => CalendarRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class CalendarRemoteDataSource {
  final Dio dio;

  CalendarRemoteDataSource({required this.dio});

  Future<Either<Failure, CalendarApiModel>> getUserCalendarEvents(
      String userId) async {
    try {
      final response =
          await dio.get('${ApiEndpoints.getCalendar(userId)}/$userId');
      if (response.statusCode == 200 && response.data != null) {
        final calendarApiModel = CalendarApiModel.fromJson(response.data);
        return Right(calendarApiModel);
      } else {
        return Left(Failure(
          error:
              "Failed to fetch calendar events. Response status: ${response.statusCode}",
        ));
      }
    } on DioError catch (e) {
      return Left(Failure(
        error: "Dio error occurred: ${e.message}",
        statusCode: e.response?.statusCode.toString(),
      ));
    } catch (e) {
      return Left(Failure(
        error: "An unexpected error occurred: ${e.toString()}",
      ));
    }
  }
}

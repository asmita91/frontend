import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';

class HealthInfoState {
  final bool isLoading;
  final HealthInfoEntity? healthInfo;
  final String? error;

  HealthInfoState({
    required this.isLoading,
    this.healthInfo,
    this.error,
  });

  factory HealthInfoState.initial() {
    return HealthInfoState(
      isLoading: false,
      healthInfo: null,
    );
  }

  HealthInfoState copyWith({
    bool? isLoading,
    HealthInfoEntity? healthInfo,
    String? error,
  }) {
    return HealthInfoState(
      isLoading: isLoading ?? this.isLoading,
      healthInfo: healthInfo ?? this.healthInfo,
      error: error ?? this.error,
    );
  }
}

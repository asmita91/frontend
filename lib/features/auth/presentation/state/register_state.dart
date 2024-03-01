import 'package:crimson_cycle/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:flutter/material.dart';

class RegisterState {
  final List<Widget> lstWidgets;
  final int index;

   RegisterState({
    required this.lstWidgets,
    required this.index,
  });

  factory RegisterState.initial() {
    return RegisterState(
      lstWidgets: [
        const DashboardView(),
        
      ],
      index: 0,
    );
  }

  RegisterState copyWith({
    List<Widget>? lstWidgets,
    int? index,
  }) {
    return RegisterState(
      lstWidgets: lstWidgets ?? this.lstWidgets,
      index: index ?? this.index,
    );
  }

  @override
  String toString() => 'RegisterState(lstWidgets: $lstWidgets, index: $index)';
}

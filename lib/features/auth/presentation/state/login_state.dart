import 'package:crimson_cycle/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:flutter/material.dart';

class LoginState {
  final List<Widget> lstWidgets;
  final int index;

   LoginState({
    required this.lstWidgets,
    required this.index,
  });

  factory LoginState.initial() {
    return LoginState(
      lstWidgets: [
        const DashboardView(),
        
      ],
      index: 0,
    );
  }

  LoginState copyWith({
    List<Widget>? lstWidgets,
    int? index,
  }) {
    return LoginState(
      lstWidgets: lstWidgets ?? this.lstWidgets,
      index: index ?? this.index,
    );
  }

  @override
  String toString() => 'LoginState(lstWidgets: $lstWidgets, index: $index)';
}

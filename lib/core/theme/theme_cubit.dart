import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Cubit<ThemeData> {
  ThemeBloc() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    useMaterial3: true,
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    useMaterial3: true,
  );

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}

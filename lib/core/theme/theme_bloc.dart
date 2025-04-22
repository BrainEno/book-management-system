import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the theme state
class ThemeState {
  final ThemeMode themeMode;
  ThemeState(this.themeMode);
}

// Define theme events
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

// ThemeBloc to manage theme state
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeMode.light)) {
    on<ToggleTheme>((event, emit) {
      // Toggle between light and dark themes
      final newThemeMode =
          state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      emit(ThemeState(newThemeMode));
    });
  }
}

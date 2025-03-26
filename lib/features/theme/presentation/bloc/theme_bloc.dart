import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          ThemeState(themeMode: ThemeMode.dark),
        ) {
    on<ThemeEvent>((event, emit) {});
    on<ChangeThemeMode>(_changeThemeMode);
  }

  Future<void> _changeThemeMode(
      ChangeThemeMode event, Emitter<ThemeState> emit) async {
    if (state.themeMode == ThemeMode.dark) {
      emit(ThemeState(themeMode: ThemeMode.light));
    } else {
      emit(ThemeState(themeMode: ThemeMode.dark));
    }
  }
}

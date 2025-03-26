part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent extends Equatable {}

final class ChangeThemeMode extends ThemeEvent {
  ChangeThemeMode();

  @override
  List<Object?> get props => [];
}

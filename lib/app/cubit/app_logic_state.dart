part of 'app_logic_cubit.dart';

@freezed
class AppLogicState with _$AppLogicState {
  const factory AppLogicState.initial() = _Initial;
  const factory AppLogicState.isDarkMode(bool darkMode) = IsDark;

  const factory AppLogicState.isLanguageEnglish(bool isEnglish) = IsEnglish;

}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:salaa/app/app_prefs.dart';

part 'app_logic_state.dart';
part 'app_logic_cubit.freezed.dart';

class AppLogicCubit extends Cubit<AppLogicState> {
  AppLogicCubit(this.appPreferences) : super(const AppLogicState.initial());
  final AppPreferences appPreferences;

  bool isDarkMode = true;

  //theme mode
  Future<void> changeAppTheme(bool? sharedMode) async {
    if (sharedMode != null) {
      isDarkMode = sharedMode;
      emit(AppLogicState.isDarkMode(isDarkMode));
    } else {
      isDarkMode = !isDarkMode;
      appPreferences
          .setDark(isDarkMode)
          .then((value) => emit(AppLogicState.isDarkMode(isDarkMode)));
    }
  }
}

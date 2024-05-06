import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:salaa/app/app_prefs.dart';

import 'package:salaa/domain/model/login/login_model.dart';
import 'package:salaa/domain/useCase/login/login_use_case.dart';
import 'package:salaa/presentation/common/freez/freezed.dart';
import 'package:salaa/presentation/common/stateRenderer/state_renderer.dart';
import 'package:salaa/presentation/common/stateRenderer/state_renderer_impl.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase, this.appPreferences)
      : super(const LoginState.initial());
  final AppPreferences appPreferences;
  final LoginUseCase _loginUseCase;
  var loginObject = LoginObject("", "");

  void login() async {
    emit(LoginState.loading(LoadingState(
        stateRenderType: StateRenderType.popupLoadingState, message: '')));

    (await _loginUseCase.execute(LoginUseCaseInput(
      loginObject.email,
      loginObject.password,
    )))
        .fold(
            (failure) => {
                  // left -> failure

                  if (failure.message ==
                      "please check your internet connection")
                    {
                      emit(
                        LoginState.error(InternetConnectionState(
                          stateRenderType:
                              StateRenderType.popupInternetConnectionState,
                          message: failure.message!,
                        )),
                      )
                    }
                  else
                    {
                      emit(
                        LoginState.error(ErrorState(
                          stateRenderType: StateRenderType.popupErrorState,
                          message: failure.message!,
                        )),
                      )
                    }
                }, (data) async {
      //right -> data(success)

      emit(
        LoginState.success(data),
      );
    });
  }

  setEmailId(String email) {
    loginObject = loginObject.copyWith(email: email.trim());
  }

  setPassword(String password) {
    loginObject = loginObject.copyWith(password: password.trim());
  }
}

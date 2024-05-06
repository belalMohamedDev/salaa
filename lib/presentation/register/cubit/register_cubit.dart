import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:salaa/app/app_prefs.dart';
import 'package:salaa/domain/model/register/register_model.dart';
import 'package:salaa/domain/useCase/register/register_use_case.dart';
import 'package:salaa/presentation/common/freez/freezed.dart';
import 'package:salaa/presentation/common/stateRenderer/state_renderer.dart';
import 'package:salaa/presentation/common/stateRenderer/state_renderer_impl.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState<dynamic>> {
  RegisterCubit(this._registerUseCase, this.appPreferences)
      : super(const RegisterState.initial());
  final AppPreferences appPreferences;
  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("", "", "", "");

  void register() async {
    emit(RegisterState.loading(LoadingState(
        stateRenderType: StateRenderType.popupLoadingState, message: '')));

    (await _registerUseCase.execute(RegisterUseCaseInput(
      registerObject.name,
      registerObject.email,
      registerObject.phone,
      registerObject.password,
    )))
        .fold(
            (failure) => {
                  // left -> failure
                  if (failure.message ==
                      "please check your internet connection")
                    {
                      emit(
                        RegisterState.error(InternetConnectionState(
                          stateRenderType:
                              StateRenderType.popupInternetConnectionState,
                          message: failure.message!,
                        )),
                      )
                    }
                  else
                    {
                      emit(
                        RegisterState.error(ErrorState(
                          stateRenderType: StateRenderType.popupErrorState,
                          message: failure.message!,
                        )),
                      )
                    }
                }, (data) async {
      //right -> data(success)

      emit(
        RegisterState.success(data),
      );
    });
  }

  setEmailId(String email) {
    registerObject = registerObject.copyWith(email: email.trim());
  }

  setName(String name) {
    registerObject = registerObject.copyWith(name: name.trim());
  }

  setPassword(String password) {
    registerObject = registerObject.copyWith(password: password.trim());
  }

  setPhone(String phone) {
    registerObject = registerObject.copyWith(phone: phone.trim());
  }
}

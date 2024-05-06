part of 'login_cubit.dart';

@freezed
class LoginState<T> with _$LoginState<T>  {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading(FlowState flowState) = Loading;
  const factory LoginState.success(LoginModel data) = Success<T>;
  const factory LoginState.error(FlowState flowState) = Error;

}

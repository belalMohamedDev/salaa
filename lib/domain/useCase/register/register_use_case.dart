import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';

import 'package:salaa/domain/model/register/register_model.dart';
import 'package:salaa/domain/repositry/repositry.dart';

import '../../../data/network/request/register/register_request.dart';
import '../base/base_use_case.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, RegisterModel> {
  final Repository _repositry;
  RegisterUseCase(this._repositry);
  @override
  Future<Either<ApiErrorModel, RegisterModel>> execute(
      RegisterUseCaseInput input) async {
    return await _repositry.register(RegisterRequest(
      input.name,
      input.email,
      input.phone,
      input.password,
    ));
  }
}

class RegisterUseCaseInput {
  String name;
  String email;
  String phone;
  String password;

  RegisterUseCaseInput(
    this.name,
    this.email,
    this.phone,
    this.password,
  );
}

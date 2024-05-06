
import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';
import 'package:salaa/domain/repositry/repositry.dart';


import '../../../data/network/request/login/login_request.dart';
import '../../model/login/login_model.dart';
import '../base/base_use_case.dart';


class LoginUseCase implements BaseUseCase<LoginUseCaseInput,LoginModel>{
  final Repository _repositry;
  LoginUseCase(this._repositry);
  @override
  Future<Either<ApiErrorModel, LoginModel>> execute(LoginUseCaseInput input)async {
   return await _repositry.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}
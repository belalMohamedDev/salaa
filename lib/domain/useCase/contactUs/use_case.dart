



import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';
import 'package:salaa/domain/model/contactUs/contact_us_model.dart';


import '../../repositry/repositry.dart';
import '../base/base_use_case.dart';

class GetContactUseCase implements BaseUseCase<void,ContactUsModel>{
  final Repository _repositry;
  GetContactUseCase(this._repositry);
  @override
  Future<Either<ApiErrorModel, ContactUsModel>> execute(void input)async {
    return await _repositry.getContacts();
  }
}
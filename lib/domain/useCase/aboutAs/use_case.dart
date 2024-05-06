


import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';
import 'package:salaa/domain/model/aboutAs/about_as_model.dart';


import '../../repositry/repositry.dart';
import '../base/base_use_case.dart';

class GetSettingsUseCase implements BaseUseCase<void,AboutAsModel>{
  final Repository _repositry;
  GetSettingsUseCase(this._repositry);
  @override
  Future<Either<ApiErrorModel, AboutAsModel>> execute(void input)async {
    return await _repositry.getSettings();
  }
}
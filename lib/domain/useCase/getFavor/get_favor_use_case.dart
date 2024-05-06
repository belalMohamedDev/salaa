


import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';

import '../../model/getFvor/get_favor_model.dart';
import '../../repositry/repositry.dart';
import '../base/base_use_case.dart';

class GetFavorUseCase implements BaseUseCase<void,GetFavoriteDataModel>{
  final Repository _repositry;
  GetFavorUseCase(this._repositry);
  @override
  Future<Either<ApiErrorModel, GetFavoriteDataModel>> execute(void input)async {
    return await _repositry.getFavor();
  }
}
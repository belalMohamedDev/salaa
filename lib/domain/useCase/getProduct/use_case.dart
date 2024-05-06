


import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';


import '../../model/getProduct/model.dart';
import '../../repositry/repositry.dart';
import '../base/base_use_case.dart';

class GetProductUseCase implements BaseUseCase<void,GetProductDaTaModel>{
  final Repository _repositry;
  GetProductUseCase(this._repositry);
  @override
  Future<Either<ApiErrorModel, GetProductDaTaModel>> execute(void input)async {
    return await _repositry.getProducts();
  }
}
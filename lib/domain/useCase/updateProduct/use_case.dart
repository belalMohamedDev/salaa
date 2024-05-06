

import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';


import '../../../data/network/request/updateProduct/product.dart';
import '../../model/updateProduct/model.dart';
import '../../repositry/repositry.dart';
import '../base/base_use_case.dart';

class UpdateProductUseCase implements BaseUseCase<UpdateProductUseCaseInput,UpdateProductDaTaModel>{
  final Repository _repositry;
  UpdateProductUseCase(this._repositry);
  @override
  Future<Either<ApiErrorModel, UpdateProductDaTaModel>> execute(UpdateProductUseCaseInput input)async {
    return await _repositry.updateProduct(UpdateProductRequest(input.productId,input.id));
  }
}

class UpdateProductUseCaseInput{
  int productId;
  int id;
  UpdateProductUseCaseInput(this.productId,this.id);
}
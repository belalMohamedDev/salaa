
import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';


import '../../../data/network/request/addProduct/request.dart';
import '../../model/AddProduct/model.dart';

import '../../repositry/repositry.dart';
import '../base/base_use_case.dart';

class AddProductUseCase implements BaseUseCase<AddProductUseCaseInput,AddProductModel>{
  final Repository _repositry;
  AddProductUseCase(this._repositry);
  @override
  Future<Either<ApiErrorModel, AddProductModel>> execute(AddProductUseCaseInput input)async {
    return await _repositry.addProducts(ProductRequest(input.id));
  }
}

class AddProductUseCaseInput{
  int id;
  AddProductUseCaseInput(this.id);
}
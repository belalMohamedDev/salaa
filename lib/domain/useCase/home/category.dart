

import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';
import 'package:salaa/domain/model/home/category.dart';


import '../../repositry/repositry.dart';
import '../base/base_use_case.dart';

class CategoryUseCase implements BaseUseCase<void,CategoryModel>{
  final Repository _repositry;
  CategoryUseCase(this._repositry);
  @override
  Future<Either<ApiErrorModel, CategoryModel>> execute(void input)async {
    return await _repositry.category();
  }
}

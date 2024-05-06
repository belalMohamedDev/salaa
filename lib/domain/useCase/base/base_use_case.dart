import 'package:dartz/dartz.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';


abstract class BaseUseCase<In,Out>{
  Future<Either<ApiErrorModel,Out>>execute(In input);
}
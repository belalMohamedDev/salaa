import 'package:dio/dio.dart';
import 'package:salaa/data/network/failure/api_error_model.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forBidden,
  unAutorised,
  notFound,
  internetServerError,
  connectTimeOut,
  cancel,
  recieveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unKnown,
  failureRequest,
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    switch (this) {
      case DataSource.success:
        return ApiErrorModel(status: true, message: ResponseMessage.success);
      case DataSource.noContent:
        return ApiErrorModel(status: true, message: ResponseMessage.noContent);

      case DataSource.forBidden:
        return ApiErrorModel(message: ResponseMessage.forBidden);
      case DataSource.unAutorised:
        return ApiErrorModel(message: ResponseMessage.unAutorised);
      case DataSource.notFound:
        return ApiErrorModel(message: ResponseMessage.notFound);
      case DataSource.internetServerError:
        return ApiErrorModel(message: ResponseMessage.internetServerError);
      case DataSource.connectTimeOut:
        return ApiErrorModel(message: ResponseMessage.connectTimeOut);
      case DataSource.cancel:
        return ApiErrorModel(message: ResponseMessage.cancel);
      case DataSource.recieveTimeOut:
        return ApiErrorModel(message: ResponseMessage.recieveTimeOut);
      case DataSource.sendTimeOut:
        return ApiErrorModel(message: ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return ApiErrorModel(message: ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return ApiErrorModel(message: ResponseMessage.noInternetConnection);
      case DataSource.unKnown:
        return ApiErrorModel(message: ResponseMessage.unKnown);
      case DataSource.failureRequest:
        return ApiErrorModel(message: ResponseMessage.failureRequest);
      case DataSource.badRequest:
        return ApiErrorModel(message: ResponseMessage.badRequest);
    }
  }
}

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      apiErrorModel = _handleError(error);
    } else {
      // default error
      apiErrorModel = DataSource.unKnown.getFailure();
    }
  }
}

ApiErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeOut.getFailure();

    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();

    case DioExceptionType.receiveTimeout:
      return DataSource.recieveTimeOut.getFailure();

    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return ApiErrorModel.fromJson(error.response!.data);
      } else {
        return DataSource.unKnown.getFailure();
      }
    case DioExceptionType.unknown:
      return DataSource.unKnown.getFailure();

    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();

    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();

    case DioExceptionType.badCertificate:
      return DataSource.badRequest.getFailure();
  }
}

class ResponseMessage {
  static const String success = "Success"; //success with data
  static const String noContent = "Success"; //success with no data (no content)
  static const String badRequest =
      "Bad Request, Try again later"; //failure api rejected request
  static const String unAutorised =
      "User is unauthorised, Try again later"; //failure , user is not authorised (token expire)
  static const String forBidden =
      "Forbidden Request, Try again later"; //failure api rejected request
  static const String notFound = "Failure ,not found";
  static const String internetServerError =
      "some Thing went wrong ,Try again later"; //failure crash in server side
  static const String failureRequest =
      "The given data was invalid."; //failure api rejected request

  //local status code
  static const String connectTimeOut = "Time out error ,Try again later";
  static const String cancel = "Request was cancelled ,Try again later";
  static const String recieveTimeOut = "Time out error ,Try again later";
  static const String sendTimeOut = "Time out error ,Try again later";
  static const String cacheError = "Cache error ,Try again later";
  static const String noInternetConnection =
      "please check your internet connection";
  static const String unKnown = "some Thing went wrong ,Try again later";
}

class ApiInternalStatus {
  static const bool success = true;
  static const bool failure = false;
}

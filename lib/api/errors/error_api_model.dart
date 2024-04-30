import 'package:dio/dio.dart';
import 'package:sarmad/api/errors/error_api_helper.dart';
import 'package:sarmad/api/errors/locale_dio_exceptions.dart';


class ErrorApiModel {
  final bool isMessageLocalizationKey;
  final String error;
  final int status;
  ErrorApiModel({
    required this.isMessageLocalizationKey,
    required this.error,
    required this.status,
  });

  factory ErrorApiModel.fromDioError(DioError dioError) {
    late int codeError;
    switch (dioError.type) {
      case DioErrorType.cancel:
        codeError = 1001;
        break;
      case DioErrorType.connectionTimeout:
        codeError = 1002;
        break;
      case DioErrorType.receiveTimeout:
        codeError = 1003;
        break;
      case DioErrorType.badResponse:
      // use code from 1004 - 1010
        codeError = ErrorApiHelper.handleResponseErrorCode(
          dioError.response?.statusCode,
        );
        break;
      case DioErrorType.sendTimeout:
        codeError = 1011;

        break;
      default:
        codeError = 1014;
        break;
    }
    if (codeError <= 1004 || codeError >= 1010) {
      return ErrorApiModel.fromJson(dioError);
    } else {
      return ErrorApiModel(
          status: codeError,
          isMessageLocalizationKey: true,
          error: LocaleDioExceptions.getLocaleMessage(codeError));
    }
  }

  factory ErrorApiModel.identifyError({dynamic error}) {
    ErrorApiModel errorApiModel;
    String? stackTrace = "";
    if (error is TypeError) {
      stackTrace = error.stackTrace.toString();
      errorApiModel = ErrorApiModel(
          status: 1015,
          error:
          ErrorApiHelper.formErrorMessage(error.toString(), stackTrace),
          isMessageLocalizationKey: false);
    } else {
      errorApiModel = ErrorApiModel(
          status: 1015,
          error: LocaleDioExceptions.getLocaleMessage(1015),
          isMessageLocalizationKey: true);
    }
    return errorApiModel;
  }

  factory ErrorApiModel.fromJson(DioError error) {
    Map<String, dynamic> extractedData =
    error.response?.data as Map<String, dynamic>;
    return ErrorApiModel(
        status: error.response?.statusCode ?? 1007,
        error: extractedData["error"],
        isMessageLocalizationKey: false);
  }
}
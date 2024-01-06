import 'package:dio/dio.dart';
import 'package:nike/utils/exeptions.dart';

validateResponse(Response response) {
  if (response.statusCode != 200) {
    throw AppException();
  }
}

import 'package:dio/dio.dart';

class HttpResponse {
  int code;
  String msg;
  dynamic data;
  HttpResponse({this.code, this.msg, this.data});
}

class HttpClient {
  var client = Dio();
  Future<HttpResponse> requestData(String path,
      {Map<String, dynamic> queryParameters,
      dynamic data,
      String method = 'get'}) async {
    try {
      var resp = method == 'get'
          ? await client.get(path, queryParameters: queryParameters)
          : await client.post(path, data: data);
      return HttpResponse(
          code: resp.data['code'],
          msg: resp.data['msg'],
          data: resp.data['data']);
    } on DioError catch (e) {
      String message = e.message;
      print(message);
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        message = 'Connect Timeout';
      } else if (e.type == DioErrorType.SEND_TIMEOUT) {
        message = 'Send Timeout';
      } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        message = 'Receive Timeout';
      } else if (e.type == DioErrorType.RESPONSE) {
        message = 'Server Not Fount';
      }
      return Future.error(message);
    }
  }
}

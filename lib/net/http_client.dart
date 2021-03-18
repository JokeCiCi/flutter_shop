import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/config.dart';
import 'package:flutter_shop/factory/factory.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class HttpResponseBody {
  static const int codeResponseError = -2; // 响应错误
  static const int codeRequestError = -1; // 请求错误
  static const int codeOk = 0; // 成功

  final int code;
  final String msg;
  final dynamic data;
  HttpResponseBody({this.code, this.msg, this.data});

  factory HttpResponseBody.fromJson(Map<String, dynamic> json) {
    return HttpResponseBody(
        code: json['code'], msg: json['msg'], data: json['data']);
  }

  Map<String, dynamic> toJson() {
    return {
      'code': this.code,
      'msg': this.msg,
      'data': this.data,
    };
  }
}

class HttpClient {
  final _client = Dio();
  final _logger = AppFactory.getInstance().getLogger('HttpClient');

  HttpClient(PersistCookieJar cookieJar) {
    _client.options.baseUrl = Config.apiBaseUrl;
    _client.interceptors.add(CookieManager(cookieJar));
  }

  Future<HttpResponseBody> request(String method, String path,
      {dynamic data}) async {
    if (Config.isLogApi) {
      _logger.fine('request $method $path');
    }

    var httpResp = Response();
    // if (Config.isMockApi) {
    //   assert(mockApis[path] != null, 'api $path not mocked');
    //   httpResp.statusCode = HttpStatus.ok;
    //   httpResp.data = await mockApis[path](method, data);
    //   return HttpResponseBody(
    //     code: httpResp.data['code'],
    //     msg: httpResp.data['msg'],
    //     data: httpResp.data['data'],
    //   );
    // }

    try {
      httpResp = await _client.request(path,
          data: data, options: Options(method: method));
      if (Config.isLogApi) {
        _logger.fine('response: ${httpResp.statusCode} ${httpResp.data}');
      }
      return HttpResponseBody(
        code: httpResp.data['code'],
        msg: httpResp.data['msg'],
        data: httpResp.data['data'],
      );
    } on DioError catch (e) {
      // http错误处理
      String message = e.message;
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

  Future<HttpResponseBody> get(String path, {Map<String, dynamic> data}) async {
    return request('GET', path, data: data);
  }

  Future<HttpResponseBody> post(String path,
      {Map<String, dynamic> data}) async {
    return request('POST', path, data: data);
  }

  Future<HttpResponseBody> postForm(String path, {FormData data}) async {
    return request('POST', path, data: data);
  }
}

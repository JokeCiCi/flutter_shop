import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_shop/config/config.dart';
import 'package:flutter_shop/net/http_client.dart';
import 'package:flutter_shop/routes/routes.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

class AppFactory {
  // 封装常用组件实例
  static AppFactory _instance; // 单例对象
  AppFactory._internal(); // 内部构造
  factory AppFactory.getInstance() => _getInstance(); // 工厂构造
  static _getInstance() {
    // 只能有一个实例
    if (_instance == null) {
      _instance = AppFactory._internal();
    }
    return _instance;
  }

  // 日志
  Map<String, Logger> _loggers = {};
  Logger getLogger(String name) {
    if (_loggers[name] == null) {
      Logger.root.level = Config.loggerLevel;
      final logger = Logger(name);
      logger.onRecord
          .where((record) => record.loggerName == logger.name)
          .listen((record) {
        final label =
            record.loggerName.padRight(7).substring(0, 7).toUpperCase();
        final time = record.time.toIso8601String().substring(0, 23);
        final level = record.level.toString().padRight(7);
        print('$label $time $level ${record.message}');
      });
      _loggers[name] = logger;
    }
    return _loggers[name];
  }

  // 路由
  Routes _routes;
  Routes getRoutes() {
    if (_routes == null) {
      _routes = Routes();
    }
    return _routes;
  }

  // http
  PersistCookieJar _cookieJar;
  HttpClient _httpClient;
  Future<PersistCookieJar> getCookieJar() async {
    if (_cookieJar == null) {
      var docDir = await getApplicationDocumentsDirectory();
      _cookieJar = PersistCookieJar(dir: '${docDir.path}/cookies');
    }
    return _cookieJar;
  }

  Future<HttpClient> getHttpClient() async {
    if (_httpClient == null) {
      var cookieJar = await getCookieJar();
      _httpClient = HttpClient(cookieJar);
    }
    return _httpClient;
  }
}

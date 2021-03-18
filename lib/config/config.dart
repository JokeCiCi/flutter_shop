import 'package:logging/logging.dart';

class Config {
  static const domain = 'flutter-jdapi.herokuapp.com'; // 域名
  static const apiBaseUrl = 'https://$domain/api'; // apiURL
  // static const isMockApi = true; // 是否启用mockApi

  static var loggerLevel = Level.FINER; // 日志级别
  static const isLogApi = true; // 是否记录Api日志
}

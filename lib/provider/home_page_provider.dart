import 'package:flutter/foundation.dart';
import 'package:flutter_shop/factory/factory.dart';
import 'package:flutter_shop/model/home_page_model.dart';
import 'package:flutter_shop/config/api.dart';

class HomePageProvider with ChangeNotifier {
  bool isLoading = false; // 是否加载中
  HomePageModel homePageModel; // 首页数据
  bool isError = false; // 是否错误
  String errMsg = ''; // 错误信息
  Future<void> loadHomePageModelData() async {
    isLoading = true;
    isError = false;
    errMsg = '';
    final client = await AppFactory.getInstance().getHttpClient();
    client.get(Api.HOME_PAGE).then((body) {
      isLoading = false;
      if (body.code == 200) {
        homePageModel = HomePageModel.fromJson(body.data);
      } else {
        Future.error('code:${body.code} msg:${body.msg}');
      }
      notifyListeners();
    }).catchError((error) {
      isLoading = false;
      isError = true;
      errMsg = error;
      notifyListeners();
    });
  }
}

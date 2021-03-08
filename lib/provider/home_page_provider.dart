import 'package:flutter/foundation.dart';
import 'package:flutter_shop/model/home_page_model.dart';
import 'package:flutter_shop/net/http_client.dart';
import 'package:flutter_shop/config/api.dart';

class HomePageProvider with ChangeNotifier {
  bool isLoading = false; // 是否加载中
  HomePageModel homePageModel; // 数据
  bool isError = false; // 是否错误
  String errMsg = ''; // 错误信息
  void loadHomePageModelData() {
    isLoading = true;
    isError = false;
    errMsg = '';
    HttpClient().requestData(Api.HOME_PAGE).then((resp) {
      print('dio resp: ${resp.data}');
      isLoading = false;
      if (resp.code == 200) {
        homePageModel = HomePageModel.fromJson(resp.data);
      }
      notifyListeners();
    }).catchError((error) {
      print('dio err: $error');
      isLoading = false;
      isError = true;
      errMsg = error;
      notifyListeners();
    });
  }
}

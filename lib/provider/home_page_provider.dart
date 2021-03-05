import 'package:flutter/foundation.dart';
import 'package:flutter_shop/model/home_page_model.dart';
import 'package:flutter_shop/net/http_client.dart';
import 'package:flutter_shop/config/api.dart';

class HomePageProvider with ChangeNotifier {
  HomePageModel homePageModel;
  bool isLoading = false;
  bool isError = false;
  String errMsg = '';
  void loadHomePageModelData() {
    isLoading = true;
    isError = false;
    errMsg = '';
    HttpClient().requestData(Api.HOME_PAGE).then((resp) {
      isLoading = false;
      if (resp.code == 200) {
        homePageModel = HomePageModel.fromJson(resp.data);
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      isLoading = false;
      isError = true;
      errMsg = error;
      notifyListeners();
    });
  }
}

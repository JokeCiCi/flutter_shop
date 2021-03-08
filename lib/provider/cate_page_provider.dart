import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_shop/net/http_client.dart';
import 'package:flutter_shop/config/api.dart';
import 'package:flutter_shop/model/cate_page_model.dart';

class CatePageProvider with ChangeNotifier {
  bool isLoading = false;
  List<String> cateNaviList = []; // 左侧导航列表
  int cateNaviIndex = 0; // 当前导航索引
  List<CateContentModel> cateContentModelList = []; // 右侧导航内容
  bool isError = false;
  String errMsg = '';

  void loadCateNaviListData() {
    isLoading = true;
    HttpClient().requestData(Api.CATE_NAVI).then((resp) {
      print('dio resp: ${resp.data}');
      isLoading = false;
      if (resp.code == 200) {
        cateNaviList =
            (resp.data as List).cast().map((e) => e.toString()).toList();
        loadCateContentListData(cateNaviIndex);
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

  void loadCateContentListData(int index) {
    cateNaviIndex = index;
    var title = cateNaviList[index];
    var data = {'title': title};
    isLoading = true;
    HttpClient()
        .requestData(Api.CATE_CONTENT, data: data, method: 'post')
        .then((resp) {
      print('dio resp: ${resp.data}');
      isLoading = false;
      if (resp.code == 200) {
        var respDataList = (resp.data as List).cast();
        cateContentModelList =
            respDataList.map((e) => CateContentModel.fromJson(e)).toList();
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

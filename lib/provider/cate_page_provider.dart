import 'package:flutter/foundation.dart';
import 'package:flutter_shop/factory/factory.dart';
import 'package:flutter_shop/config/api.dart';
import 'package:flutter_shop/model/cate_page_model.dart';

class CatePageProvider with ChangeNotifier {
  bool isLoading = false;
  List<String> cateNaviList = []; // 左侧导航列表
  int cateNaviIndex = 0; // 当前导航索引
  List<CateContentModel> cateContentModelList = []; // 右侧导航内容
  bool isError = false;
  String errMsg = '';

  Future<void> loadCateNaviListData() async {
    final client = await AppFactory.getInstance().getHttpClient();
    isLoading = true;
    client.get(Api.CATE_NAVI).then((body) {
      isLoading = false;
      if (body.code == 200) {
        cateNaviList =
            (body.data as List).cast().map((e) => e.toString()).toList();
        loadCateContentListData(cateNaviIndex);
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

  Future<void> loadCateContentListData(int index) async {
    final client = await AppFactory.getInstance().getHttpClient();
    cateNaviIndex = index;
    var title = cateNaviList[index];
    var data = {'title': title};
    isLoading = true;
    client.post(Api.CATE_CONTENT, data: data).then((body) {
      isLoading = false;
      if (body.code == 200) {
        var respDataList = (body.data as List).cast();
        cateContentModelList =
            respDataList.map((e) => CateContentModel.fromJson(e)).toList();
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

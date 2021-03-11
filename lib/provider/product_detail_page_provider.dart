import 'package:flutter/foundation.dart';
import 'package:flutter_shop/model/product_detail_page_model.dart';
import 'package:flutter_shop/net/http_client.dart';
import 'package:flutter_shop/config/api.dart';

class ProductDetailPageProvider with ChangeNotifier {
  bool isLoading = false;
  ProductDetailModel productDetailModel;
  bool isError = false;
  String errMsg = '';

  void loadProductDetailModel(String id) {
    isLoading = true;
    HttpClient().requestData(Api.PROD_DETAIL).then((resp) {
      print('dio resp: ${resp.data}');
      isLoading = false;
      if (resp.code == 200 && resp.data is List) {
        var dataList = (resp.data as List).cast();
        dataList.forEach((ele) {
          var tempModel = ProductDetailModel.fromJson(ele);
          if (tempModel.partData.id == id) {
            productDetailModel = tempModel;
          }
        });
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

  void changeBaiTiaoSelected(int index) {
    if (productDetailModel.baitiao[index].select == false) {
      for (var i = 0; i < productDetailModel.baitiao.length; i++) {
        if (i == index) {
          productDetailModel.baitiao[i].select = true;
        } else {
          productDetailModel.baitiao[i].select = false;
        }
      }
      notifyListeners();
    }
  }
}

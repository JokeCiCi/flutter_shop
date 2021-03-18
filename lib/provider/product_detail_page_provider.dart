import 'package:flutter/foundation.dart';
import 'package:flutter_shop/factory/factory.dart';
import 'package:flutter_shop/model/product_detail_page_model.dart';
import 'package:flutter_shop/net/http_client.dart';
import 'package:flutter_shop/config/api.dart';

class ProductDetailPageProvider with ChangeNotifier {
  bool isLoading = false;
  ProductDetailModel productDetailModel;
  bool isError = false;
  String errMsg = '';

  Future<void> loadProductDetailModel(String id) async {
    isLoading = true;
    final client = await AppFactory.getInstance().getHttpClient();
    client.get(Api.PROD_DETAIL).then((body) {
      isLoading = false;
      if (body.code == 200) {
        var dataList = (body.data as List).cast();
        dataList.forEach((ele) {
          var tempModel = ProductDetailModel.fromJson(ele);
          if (tempModel.partData.id == id) {
            productDetailModel = tempModel;
          }
        });
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

  void changeProductCount(int count) {
    if (count > 0 && productDetailModel.partData.count != count) {
      productDetailModel.partData.count = count;
      notifyListeners();
    }
  }
}

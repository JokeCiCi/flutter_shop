import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/model/product_detail_page_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPageProvider with ChangeNotifier {
  List<PartData> productDataList = [];
  Future<void> addToCart(PartData product) async {
    // 从持久性存储读出字符串数据
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cacheList = prefs.getStringList('cartInfo');
    productDataList.clear();
    if (null == cacheList) {
      // 没有缓存
      List<String> tempList = [json.encode(product.toJson())];
      prefs.setStringList('cartInfo', tempList); // 写入缓存
      // 更新本地数据
      productDataList.add(product);
      // 通知听众
      notifyListeners();
    } else {
      // 有缓存
      List<String> tempList = [];
      var isCached = false; // 判断传参是否在缓存中
      cacheList.forEach((ele) {
        var tempPart = PartData.fromJson(json.decode(ele));
        if (tempPart.id == product.id) {
          tempPart.count = product.count;
          isCached = true;
        }
        tempList.add(json.encode(tempPart));
        productDataList.add(tempPart);
      });
      if (isCached == false) {
        // 缓存不存在传参数据
        tempList.add(json.encode(product));
        productDataList.add(product);
      }
      prefs.setStringList('cartInfo', tempList); // 写入缓存
      notifyListeners();
    }
  }

  int getAllProductCount() {
    int count = 0;
    productDataList.forEach((element) => count += element.count);
    return count;
  }
}

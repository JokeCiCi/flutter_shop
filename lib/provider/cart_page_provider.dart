import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/model/product_detail_page_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPageProvider with ChangeNotifier {
  List<PartData> productDataList = [];
  bool isSelectAll = false;

  Future<void> cartLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cacheList = prefs.getStringList('cartInfo');
    if (cacheList != null) {
      productDataList =
          cacheList.map((e) => PartData.fromJson(json.decode(e))).toList();

      isSelectAll = getSelectedCount() == productDataList.length ? true : false;
    }
    notifyListeners();
  }

  Future<void> cartSync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cacheList =
        productDataList.map((e) => json.encode(e.toJson())).toList();
    prefs.setStringList('cartInfo', cacheList);
    notifyListeners();
  }

  Future<void> cartAdd(PartData product) async {
    var exists = false;
    for (var i = 0; i < productDataList.length; i++) {
      if (productDataList[i].id == product.id) {
        productDataList[i].count = product.count;
        exists = true;
      }
    }
    if (!exists) {
      productDataList.add(product);
    }

    await cartSync();
    notifyListeners();
  }

  Future<void> cartDel(String id) async {
    for (var i = 0; i < productDataList.length; i++) {
      if (productDataList[i].id == id) {
        productDataList.remove(productDataList[i]);
        break;
      }
    }
    await cartSync();
    notifyListeners();
  }

  int getAllProductCount() {
    int count = 0;
    productDataList.forEach((element) => count += element.count);
    return count;
  }

  Future<void> changeSelect(String id) async {
    for (var i = 0; i < productDataList.length; i++) {
      if (productDataList[i].id == id) {
        productDataList[i].isSelected = !productDataList[i].isSelected;
        break;
      }
    }

    isSelectAll = getSelectedCount() == productDataList.length ? true : false;
    await cartSync();
    notifyListeners();
  }

  Future<void> changeSelectAll() async {
    isSelectAll = !isSelectAll;
    for (var i = 0; i < productDataList.length; i++) {
      productDataList[i].isSelected = isSelectAll;
    }
    await cartSync();
    notifyListeners();
  }

  String getAllAmount() {
    String allAmnount = '0.00';
    for (var i = 0; i < productDataList.length; i++) {
      num amount = NumUtil.getNumByValueStr(productDataList[i].price,
              fractionDigits: 2) *
          productDataList[i].count;
      allAmnount = NumUtil.add(
              NumUtil.getNumByValueStr(allAmnount, fractionDigits: 2), amount)
          .toString();
    }
    return allAmnount;
  }

  int getSelectedCount() {
    int selectedCount = 0;
    for (var i = 0; i < productDataList.length; i++) {
      if (productDataList[i].isSelected) {
        selectedCount++;
      }
    }
    return selectedCount;
  }
}

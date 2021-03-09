import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/model/productlist_page_model.dart';
import 'package:flutter_shop/net/http_client.dart';
import 'package:flutter_shop/config/api.dart';

class ProductListPageProvider with ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> productModelList = [];
  bool isError = false;
  String errMsg = '';
  void loadProductModelListData() {
    isLoading = true;
    HttpClient().requestData(Api.PROD_LIST).then((resp) {
      print('dio resp: ${resp.data}');
      isLoading = false;
      if (resp.code == 200 && resp.data is List) {
        var dataList = (resp.data as List).cast();
        productModelList =
            dataList.map((e) => ProductModel.fromJson(e)).toList();
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

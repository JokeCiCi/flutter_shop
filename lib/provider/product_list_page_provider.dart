import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/factory/factory.dart';
import 'package:flutter_shop/config/api.dart';
import 'package:flutter_shop/model/product_list_page_model.dart';

class ProductListPageProvider with ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> productModelList = [];
  bool isError = false;
  String errMsg = '';
  Future<void> loadProductModelListData() async {
    isLoading = true;
    final client = await AppFactory.getInstance().getHttpClient();
    client.get(Api.PROD_LIST).then((body) {
      isLoading = false;
      if (body.code == 200 && body.data is List) {
        var dataList = (body.data as List).cast();
        productModelList =
            dataList.map((e) => ProductModel.fromJson(e)).toList();
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

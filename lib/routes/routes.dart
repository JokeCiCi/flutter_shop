import 'package:flutter_shop/page/product_list_page.dart';
import 'package:flutter_shop/page/product_detail_page.dart';
import 'package:fluro/fluro.dart';

var handlers = {
  '/productions/:title': Handler(
      handlerFunc: (context, params) =>
          ProductListPage(title: params['title'][0])),
  'productDetail/:id': Handler(
      handlerFunc: (context, params) => ProductDetailPage(id: params['id'][0])),
};

class Routes {
  static FluroRouter router;
  static void defineRoutes(FluroRouter router) {
    handlers.forEach((path, handler) => router.define(path, handler: handler));
  }
}

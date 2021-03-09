import 'package:fluro/fluro.dart';
import 'package:flutter_shop/page/productlist_page.dart';

var handlers = {
  '/productions/:title': Handler(
      handlerFunc: (context, params) =>
          ProductListPage(title: params['title'][0])),
};

class Routes {
  static FluroRouter router;
  static void defineRoutes(FluroRouter router) {
    handlers.forEach((path, handler) => router.define(path, handler: handler));
  }
}

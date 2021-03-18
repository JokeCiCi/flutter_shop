import 'package:flutter/material.dart';
import 'package:flutter_shop/page/index_page.dart';
import 'package:flutter_shop/page/product_list_page.dart';
import 'package:flutter_shop/page/product_detail_page.dart';

// 路由配置
class Routes {
  final Map<String, WidgetBuilder> _routes = {
    '/': (context) => IndexPage(),
    '/productList': (context, {arguments}) => ProductListPage(title: arguments),
    '/productDetail': (context, {arguments}) => ProductDetailPage(id: arguments)
  };
  // 路由跳转时触发
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final String routeName = settings.name; // 路由名称
    final Function routeBuilder = this._routes[routeName]; // 路由builder
    print(routeName);
    print(routeBuilder);
    if (routeBuilder != null) {
      if (settings.arguments != null) {
        return MaterialPageRoute(
            builder: (context) =>
                routeBuilder(context, arguments: settings.arguments));
      } else {
        return MaterialPageRoute(builder: (context) => routeBuilder(context));
      }
    }
    return null;
  }
}

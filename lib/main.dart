import 'package:flutter/material.dart';
import 'package:flutter_shop/factory/factory.dart';
import 'package:flutter_shop/provider/cart_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/page/index_page.dart';
import 'package:flutter_shop/provider/bottom_navi_provider.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider<BottomNaviProvider>(
          create: (_) => BottomNaviProvider()),
      ChangeNotifierProvider<CartPageProvider>(
          create: (_) => CartPageProvider())
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '京东商城',
        theme: ThemeData(primaryColor: Colors.blue),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppFactory.getInstance().getRoutes().onGenerateRoute,
        initialRoute: '/');
  }
}

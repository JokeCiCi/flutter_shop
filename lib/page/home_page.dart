import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api.dart';
import 'package:flutter_shop/net/http_client.dart';
import 'package:flutter_shop/provider/home_page_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        var provider = HomePageProvider();
        provider.loadHomePageModelData();
        return provider;
      },
      child: Consumer<HomePageProvider>(builder: (_, obj, __) {
        return Scaffold(
          appBar: AppBar(title: Text('首页')),
          body: Center(child: Text('首页')),
        );
      }),
    );
  }
}

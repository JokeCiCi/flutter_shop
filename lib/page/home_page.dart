import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      child: Scaffold(
          appBar: AppBar(title: Text('首页')),
          body: Consumer<HomePageProvider>(builder: (_, obj, __) {
            if (obj.isLoading) {
              return Center(child: CupertinoActivityIndicator()); // 加载动画
            }
            if (obj.isError) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(obj.errMsg),
                      TextButton(
                          child: Text('刷新'),
                          onPressed: () {
                            obj.loadHomePageModelData();
                          })
                    ]),
              ); // 刷新
            }
            return Center(child: Text('首页'));
          })),
    );
  }
}

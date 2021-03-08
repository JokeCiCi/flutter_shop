import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/page/home_page.dart';
import 'package:flutter_shop/page/cate_page.dart';
import 'package:flutter_shop/page/cart_page.dart';
import 'package:flutter_shop/page/user_page.dart';
import 'package:flutter_shop/provider/bottom_navi_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> _bottomNavis = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: '分类'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '购物车'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ];
  final List<Widget> _naviBodies = [
    HomePage(),
    CatePage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(750, 1334),
        allowFontScaling: false);
    return Scaffold(
        body: Consumer<BottomNaviProvider>(
            builder: (_, obj, __) => IndexedStack(
                  children: _naviBodies,
                  index: obj.bottomNaviIndex,
                )),
        bottomNavigationBar: Consumer<BottomNaviProvider>(
            builder: (_, obj, __) => BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: _bottomNavis,
                currentIndex: obj.bottomNaviIndex,
                onTap: (index) => obj.changeBottomNaviIndex(index))));
  }
}

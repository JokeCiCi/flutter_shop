import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/product_detail_page_model.dart';
import 'package:flutter_shop/provider/cart_page_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('购物车')), body: buildBody());
  }

  Widget buildBody() {
    return Consumer<CartPageProvider>(builder: (_, provider, __) {
      return Stack(children: [buildListView(provider), buildBottom()]);
    });
  }

  Widget buildListView(CartPageProvider provider) {
    if (provider.productDataList.length == 0) {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(height: ScreenUtil().setHeight(50)),
            Image.asset('assets/image/shop_cart.png',
                width: ScreenUtil().setWidth(100),
                height: ScreenUtil().setHeight(100)),
            Text('购物车空空如也，快去逛逛吧！')
          ]));
    } else {
      return ListView.builder(
        itemCount: provider.productDataList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              _buildItemSelect(),
              _buildItemInfo(provider.productDataList[index]),
            ],
          );
        },
      );
    }
  }

  Widget _buildItemSelect() {
    return Container(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setHeight(150),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Image.asset('assets/image/unselect.png'));
  }

  Widget _buildItemInfo(PartData item) {
    return Container(
        width: ScreenUtil().setWidth(700),
        height: ScreenUtil().setHeight(150),
        child: Card(
            child: Row(children: [
          Container(
              width: ScreenUtil().setWidth(150),
              alignment: Alignment.center,
              child: Image.asset('assets${item.loopImgUrl[0]}',
                  fit: BoxFit.contain)),
          Container(
              width: ScreenUtil().setWidth(500),
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.title}',
                        overflow: TextOverflow.ellipsis, maxLines: 2),
                    SizedBox(height: ScreenUtil().setHeight(30)),
                    Row(children: [
                      Text('￥${item.price}',
                          style: TextStyle(color: Colors.red)),
                      Spacer(),
                      Container(
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setHeight(40),
                          alignment: Alignment.center,
                          color: Colors.black12,
                          child: Text('-')),
                      Container(
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setHeight(40),
                          alignment: Alignment.center,
                          child: Text('${item.count}')),
                      Container(
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setHeight(40),
                          alignment: Alignment.center,
                          color: Colors.black12,
                          child: Text('+'))
                    ])
                  ]))
        ])));
  }

  Widget buildBottom() {
    return Positioned(
        left: 0,
        bottom: 0,
        right: 0,
        child: Container(
            height: ScreenUtil().setHeight(80),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.black26),
                    bottom: BorderSide(color: Colors.black26))),
            child: Row(children: [
              Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Image.asset('assets/image/unselect.png')),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Text('全选', style: TextStyle(color: Colors.black26)),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Text('合计'),
              Text('￥0.00', style: TextStyle(color: Colors.red)),
              Spacer(),
              Container(
                  width: ScreenUtil().setHeight(100),
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text('去结算()'))
            ])));
  }
}

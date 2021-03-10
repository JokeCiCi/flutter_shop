import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provider/product_detail_page_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;
  const ProductDetailPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商品详情'),
        ),
        body: ChangeNotifierProvider<ProductDetailPageProvider>(create: (_) {
          var provider = ProductDetailPageProvider();
          provider.loadProductDetailModel(id);
          return provider;
        }, child:
            Consumer<ProductDetailPageProvider>(builder: (_, provider, __) {
          return buildContent(provider);
        })));
  }

  Widget buildContent(ProductDetailPageProvider provider) {
    if (provider.isLoading) {
      return buildLoading();
    }
    if (provider.isError) {
      return buildError(provider);
    }

    return Stack(children: [
      ListView(children: [
        buildSwiper(provider),
        buildTitle(provider),
        buildPrice(provider),
        buildPay(provider),
        buildCount(provider),
      ]),
      buildBottomButton(provider),
    ]);
  }

  Widget buildLoading() {
    return Center(child: CupertinoActivityIndicator());
  }

  Widget buildError(ProductDetailPageProvider provider) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(provider.errMsg),
      TextButton(
          child: Text('刷新'),
          onPressed: () => provider.loadProductDetailModel(id))
    ]));
  }

  Widget buildSwiper(ProductDetailPageProvider provider) {
    return Container(
        height: ScreenUtil().setHeight(800),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Swiper(
            itemCount: provider.productDetailModel.partData.loopImgUrl.length,
            pagination: SwiperPagination(),
            autoplay: true,
            itemBuilder: (context, index) {
              return Image.asset(
                  'assets${provider.productDetailModel.partData.loopImgUrl[index]}',
                  fit: BoxFit.fill);
            }));
  }

  Widget buildTitle(ProductDetailPageProvider provider) {
    return Container(
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text('${provider.productDetailModel.partData.title}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold)));
  }

  Widget buildPrice(ProductDetailPageProvider provider) {
    return Container(
        height: ScreenUtil().setHeight(70),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text('￥${provider.productDetailModel.partData.price}',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)));
  }

  Widget buildPay(ProductDetailPageProvider provider) {
    return Container(
        height: ScreenUtil().setHeight(60),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.black54, width: 2),
                bottom: BorderSide(color: Colors.black54, width: 1))),
        child: Row(children: [
          Text('支付', style: TextStyle(color: Colors.black54)),
          SizedBox(width: 5),
          Text('不分期'),
          Spacer(),
          Icon(Icons.more_horiz)
        ]));
  }

  Widget buildCount(ProductDetailPageProvider provider) {
    return Container(
        height: ScreenUtil().setHeight(60),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.black54, width: 1),
                bottom: BorderSide(color: Colors.black54, width: 2))),
        child: Row(children: [
          Text('已选', style: TextStyle(color: Colors.black54)),
          SizedBox(width: 5),
          Text('1件'),
          Spacer(),
          Icon(Icons.more_horiz)
        ]));
  }

  Widget buildBottomButton(ProductDetailPageProvider provider) {
    return Positioned(
        left: 0,
        bottom: 0,
        right: 0,
        child: Container(
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(width: 1, color: Colors.black45))),
            child: Row(children: [
              Expanded(
                  child: Container(
                      height: ScreenUtil().setHeight(80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.shopping_cart), Text('购物车')],
                      ))),
              Expanded(
                  child: Container(
                      height: ScreenUtil().setHeight(80),
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text('加入购物车')))
            ])));
  }
}

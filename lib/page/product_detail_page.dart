import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provider/product_detail_page_provider.dart';
import 'package:flutter_shop/routes/routes.dart';
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
          return buildContent(provider, context);
        })));
  }

  Widget buildContent(
      ProductDetailPageProvider provider, BuildContext context) {
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
        buildPay(provider, context),
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

  Widget buildPay(ProductDetailPageProvider provider, BuildContext context) {
    return InkWell(
        onTap: () => showModalBottomSheet(
            context: context,
            builder: (_) => BaiTiaoDialog(provider: provider)),
        child: Container(
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
            ])));
  }

  Widget buildCount(ProductDetailPageProvider provider) {
    return InkWell(
        onTap: () => print('件数'),
        child: Container(
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
            ])));
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
                  child: InkWell(
                      onTap: () => print('购物车'),
                      child: Container(
                          height: ScreenUtil().setHeight(80),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.shopping_cart), Text('购物车')],
                          )))),
              Expanded(
                  child: InkWell(
                      onTap: () => print('加入购物车'),
                      child: Container(
                          height: ScreenUtil().setHeight(80),
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: Text('加入购物车'))))
            ])));
  }
}

class BaiTiaoDialog extends StatelessWidget {
  final ProductDetailPageProvider provider;
  const BaiTiaoDialog({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(context.toString());
    return ChangeNotifierProvider<ProductDetailPageProvider>.value(
        value: provider,
        child: Consumer<ProductDetailPageProvider>(
          builder: (_, provider, __) {
            return Stack(children: [
              Stack(children: [
                Container(
                  width: ScreenUtil().setWidth(750),
                  height: ScreenUtil().setHeight(50),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Text('打白条购买'),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(50),
                    child: Center(
                        child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Routes.router.pop(context))))
              ]),
              Container(
                  width: ScreenUtil().setWidth(750),
                  margin: EdgeInsets.only(top: 50, bottom: 50),
                  child: ListView.builder(
                      itemCount: provider.productDetailModel.baitiao.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.all(10),
                            child: Row(children: [
                              InkWell(
                                  onTap: () => print('选择白条'),
                                  child: Image.asset(
                                      provider.productDetailModel.baitiao[index]
                                              .select
                                          ? 'assets/image/selected.png'
                                          : 'assets/image/unselect.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill)),
                              SizedBox(width: 10),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${provider.productDetailModel.baitiao[index].desc}',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(25))),
                                    Text(
                                        '${provider.productDetailModel.baitiao[index].tip}',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(25)))
                                  ]),
                            ]));
                      })),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                      onTap: () => print('白条支付'),
                      child: Container(
                          width: ScreenUtil().setWidth(750),
                          height: ScreenUtil().setHeight(50),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.red),
                          child: Text('白条支付',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))))
            ]);
          },
        ));
  }
}

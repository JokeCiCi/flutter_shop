import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/provider/product_detail_page_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;
  const ProductDetailPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailPageProvider>(
      create: (_) {
        var provider = ProductDetailPageProvider();
        provider.loadProductDetailModel(id);
        return provider;
      },
      child: Consumer<ProductDetailPageProvider>(
        builder: (_, provider, __) {
          return Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: () => Routes.router.pop(context)),
                  title: Text('商品详情')),
              body: buildContent(provider));
        },
      ),
    );
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
            onPressed: () {
              provider.loadProductDetailModel(id);
            })
      ]),
    );
  }

  Widget buildContent(ProductDetailPageProvider provider) {
    if (provider.isLoading) {
      return Container(
          width: ScreenUtil().setWidth(750), child: buildLoading());
    }
    if (provider.isError) {
      return Container(
          width: ScreenUtil().setWidth(750), child: buildError(provider));
    }

    return Stack(children: [
      ListView(children: [
        buildSwiper(provider),
        buildTitle(provider),
        buildPrice(provider),
        buildFenQi(provider),
        buildCount(provider),
      ]),
      buildBottom(provider)
    ]);
  }

  Widget buildSwiper(ProductDetailPageProvider provider) {
    return Container(
      height: ScreenUtil().setHeight(700),
      child: Swiper(
        itemCount: provider.productDetailModel.partData.loopImgUrl.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (context, index) {
          return Image.asset(
              'assets${provider.productDetailModel.partData.loopImgUrl[index]}',
              fit: BoxFit.fill);
        },
      ),
    );
  }

  Widget buildTitle(ProductDetailPageProvider provider) {
    return Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text('${provider.productDetailModel.partData.title}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(20))));
  }

  Widget buildPrice(ProductDetailPageProvider provider) {
    return Container(
        height: ScreenUtil().setHeight(50),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text('￥${provider.productDetailModel.partData.price}',
            style: TextStyle(
                color: Colors.red, fontSize: ScreenUtil().setSp(30))));
  }

  Widget buildFenQi(ProductDetailPageProvider provider) {
    return InkWell(
        onTap: () {
          print('白条');
        },
        child: Container(
            height: ScreenUtil().setHeight(50),
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 2, color: Colors.black45),
                    bottom: BorderSide(width: 1, color: Colors.black45))),
            child: Row(children: [
              Text('支付', style: TextStyle(color: Colors.black45)),
              SizedBox(width: 5),
              Text('${_getBaitiaoTitle(provider)}'),
              Spacer(),
              Icon(Icons.more_horiz)
            ])));
  }

  Widget buildCount(ProductDetailPageProvider provider) {
    return InkWell(
        onTap: () {
          print('数量');
        },
        child: Container(
            height: ScreenUtil().setHeight(50),
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.black45),
                    bottom: BorderSide(width: 2, color: Colors.black45))),
            child: Row(children: [
              Text('已选', style: TextStyle(color: Colors.black45)),
              SizedBox(width: 5),
              Text('${provider.productDetailModel.partData.count}'),
              Spacer(),
              Icon(Icons.more_horiz)
            ])));
  }

  Widget buildBottom(ProductDetailPageProvider provider) {
    return Positioned(
        left: 0,
        bottom: 0,
        right: 0,
        child: Row(children: [
          Expanded(
              child: InkWell(
                  onTap: () => print('购物车'),
                  child: Container(
                      height: ScreenUtil().setHeight(100),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border(top: BorderSide(color: Colors.black45))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart),
                            Text('购物车')
                          ])))),
          Expanded(
              child: InkWell(
                  onTap: () => print('加入购物车'),
                  child: Container(
                      height: ScreenUtil().setHeight(100),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          border:
                              Border(top: BorderSide(color: Colors.black45))),
                      child: Text('加入购物车')))),
        ]));
  }

  String _getBaitiaoTitle(ProductDetailPageProvider provider) {
    var title = '【白条支付】首单享立减优惠';
    provider.productDetailModel.baitiao.forEach((element) {
      if (element.select) {
        title = element.desc;
      }
    });
    return title;
  }
}

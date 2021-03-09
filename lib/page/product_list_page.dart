import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provider/product_list_page_provider.dart';
import 'package:flutter_shop/routes/routes.dart';

class ProductListPage extends StatelessWidget {
  final String title;
  const ProductListPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductListPageProvider>(
      create: (_) {
        var provider = ProductListPageProvider();
        provider.loadProductModelListData();
        return provider;
      },
      child: Consumer<ProductListPageProvider>(
        builder: (_, provider, __) {
          return Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: () => Routes.router.pop(context)),
                  title: Text('$title')),
              body: buildContent(provider));
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(child: CupertinoActivityIndicator());
  }

  Widget buildError(ProductListPageProvider provider) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(provider.errMsg),
        TextButton(
            child: Text('刷新'),
            onPressed: () {
              provider.loadProductModelListData();
            })
      ]),
    );
  }

  Widget buildContent(ProductListPageProvider provider) {
    if (provider.isLoading) {
      return Container(
          width: ScreenUtil().setWidth(750), child: buildLoading());
    }
    if (provider.isError) {
      return Container(
          width: ScreenUtil().setWidth(750), child: buildError(provider));
    }

    return Container(
        width: ScreenUtil().setWidth(750),
        child: ListView.builder(
            itemCount: provider.productModelList.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    print(provider.productModelList[index].toJson());
                    print(provider.productModelList[index].id);
                    Routes.router.navigateTo(context,
                        '/productDetail/${provider.productModelList[index].id}');
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                                'assets${provider.productModelList[index].cover}',
                                width: 95,
                                height: 120),
                            Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(
                                      '${provider.productModelList[index].title}',
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis),
                                  SizedBox(height: 5),
                                  Text(
                                      '￥${provider.productModelList[index].price}',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Row(children: [
                                    Text(
                                        '${provider.productModelList[index].comment}条评价',
                                        style:
                                            TextStyle(color: Colors.black38)),
                                    SizedBox(width: 5),
                                    Text(
                                        '好评率${provider.productModelList[index].rate}',
                                        style: TextStyle(color: Colors.black38))
                                  ])
                                ]))
                          ])));
            }));
  }
}

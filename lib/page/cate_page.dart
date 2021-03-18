import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/provider/cate_page_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routes/routes.dart';

class CatePage extends StatelessWidget {
  const CatePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CatePageProvider>(
        create: (_) {
          var provider = CatePageProvider();
          provider.loadCateNaviListData();
          return provider;
        },
        child: Scaffold(
            appBar: AppBar(title: Text('分类页面')),
            body: Consumer<CatePageProvider>(
              builder: (_, provider, __) {
                return buildContent(context, provider);
              },
            )));
  }

  Widget buildLoading() {
    return Center(child: CupertinoActivityIndicator());
  }

  Widget buildError(CatePageProvider provider) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(provider.errMsg),
        TextButton(
            child: Text('刷新'),
            onPressed: () {
              provider.loadCateNaviListData();
            })
      ]),
    );
  }

  Widget buildContent(BuildContext context, CatePageProvider provider) {
    return Row(children: [
      buildCateNavi(provider),
      buildCateContent(context, provider)
    ]);
  }

  Widget buildCateNavi(CatePageProvider provider) {
    if (provider.isLoading && provider.cateContentModelList.isEmpty) {
      return Container(
          width: ScreenUtil().setWidth(200), child: buildLoading());
    }
    if (provider.isError) {
      return Container(
          width: ScreenUtil().setWidth(200), child: buildError(provider));
    }
    return Container(
        width: ScreenUtil().setWidth(200),
        child: ListView.builder(
            itemCount: provider.cateNaviList.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    provider.loadCateContentListData(index);
                  },
                  child: Container(
                      height: ScreenUtil().setHeight(80),
                      alignment: Alignment.center,
                      color: provider.cateNaviIndex == index
                          ? Colors.white
                          : Colors.black12,
                      child: Text(provider.cateNaviList[index],
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              color: provider.cateNaviIndex == index
                                  ? Colors.red
                                  : Colors.black))));
            }));
  }

  Widget buildCateContent(BuildContext context, CatePageProvider provider) {
    List<Widget> widgetList = [];
    provider.cateContentModelList.forEach((ele) {
      var title = Container(
          height: ScreenUtil().setHeight(50),
          margin: EdgeInsets.all(10),
          child: Text(ele.title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold)));
      var content = Wrap(
          spacing: 10,
          runSpacing: 10,
          children: ele.desc
              .map((e) => Container(
                  width: ScreenUtil().setWidth(100),
                  child: InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed('/productList', arguments: e.text),
                      child: Column(children: [
                        Image.asset('assets${e.img}',
                            width: ScreenUtil().setWidth(80)),
                        Text('${e.text}',
                            style: TextStyle(fontSize: ScreenUtil().setSp(20)))
                      ]))))
              .toList());
      widgetList.add(title);
      widgetList.add(content);
    });

    if (provider.isLoading) {
      return Container(
          width: ScreenUtil().setWidth(550), child: buildLoading());
    }
    if (provider.isError) {
      return Container(
          width: ScreenUtil().setWidth(550), child: buildError(provider));
    }
    return Container(
        width: ScreenUtil().setWidth(550),
        color: Colors.white,
        child: ListView(children: widgetList));
  }
}

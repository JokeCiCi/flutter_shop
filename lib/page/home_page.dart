import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/model/home_page_model.dart';
import 'package:flutter_shop/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
          body: Consumer<HomePageProvider>(builder: (_, provider, __) {
            var model = provider.homePageModel;
            if (provider.isLoading) {
              return buildLoading();
            }
            if (provider.isError) {
              return buildError(provider);
            }
            return buildContent(model);
          })),
    );
  }

  Widget buildLoading() {
    return Center(child: CupertinoActivityIndicator());
  }

  Widget buildError(HomePageProvider provider) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(provider.errMsg),
        TextButton(
            child: Text('刷新'),
            onPressed: () {
              provider.loadHomePageModelData();
            })
      ]),
    );
  }

  Widget buildContent(HomePageModel model) {
    return ListView(
      children: [
        buildSwiper(model),
        buildLogo(model),
        buildMsHeader(model),
        buildMsContent(model),
        buildAd(model.pageRow.ad1),
        buildAd(model.pageRow.ad2)
      ],
    );
  }

  Widget buildSwiper(HomePageModel model) {
    return Container(
      // width: ScreenUtil().setWidth(720),
      // height: ScreenUtil().setHeight(350),
      height: ScreenUtil().setHeight(370),
      child: Swiper(
        itemCount: model.swipers.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (context, index) {
          return Image.asset("assets${model.swipers[index].image}");
        },
      ),
    );
  }

  Widget buildLogo(HomePageModel model) {
    var children = model.logos
        .map((e) =>
            Column(children: [Image.asset('assets${e.image}'), Text(e.title)]))
        .toList();
    return Container(
      height: ScreenUtil().setHeight(300),
      alignment: Alignment.center,
      child: Wrap(
        spacing: ScreenUtil().setWidth(40),
        runSpacing: ScreenUtil().setHeight(10),
        children: children,
      ),
    );
  }

  Widget buildMsHeader(HomePageModel model) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: ScreenUtil().setHeight(50),
      alignment: Alignment.center,
      child: Row(
        children: [
          Image.asset('assets/image/bej.png'),
          Spacer(),
          Text('更多秒杀>')
        ],
      ),
    );
  }

  Widget buildMsContent(HomePageModel model) {
    return Container(
      height: ScreenUtil().setHeight(250),
      alignment: Alignment.center,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: model.quicks.length,
          itemBuilder: (context, index) {
            return Column(children: [
              Image.asset('assets${model.quicks[index].image}',
                  width: ScreenUtil().setHeight(200),
                  height: ScreenUtil().setHeight(200)),
              Text('${model.quicks[index].price}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(30), color: Colors.red)),
            ]);
          }),
    );
  }

  Widget buildAd(List<String> ads) {
    var children =
        ads.map((e) => Expanded(child: Image.asset('assets${e}'))).toList();
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children));
  }
}

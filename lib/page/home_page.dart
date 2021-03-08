import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            if (provider.isLoading) {
              return buildLoading();
            }
            if (provider.isError) {
              return buildError(provider);
            }
            return buildContent(provider);
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

  Widget buildContent(HomePageProvider provider) {
    var model = provider.homePageModel;
    return ListView(
      children: [
        buildSwiper(provider),
        buildLogo(provider),
        buildMsHeader(provider),
        buildMsContent(provider),
        buildAd(model.pageRow.ad1),
        buildAd(model.pageRow.ad2)
      ],
    );
  }

  Widget buildSwiper(HomePageProvider provider) {
    return Container(
      // width: ScreenUtil().setWidth(720),
      // height: ScreenUtil().setHeight(350),
      height: ScreenUtil().setHeight(370),
      child: Swiper(
        itemCount: provider.homePageModel.swipers.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (context, index) {
          return Image.asset(
              "assets${provider.homePageModel.swipers[index].image}");
        },
      ),
    );
  }

  Widget buildLogo(HomePageProvider provider) {
    var children = provider.homePageModel.logos
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

  Widget buildMsHeader(HomePageProvider provider) {
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

  Widget buildMsContent(HomePageProvider provider) {
    return Container(
      height: ScreenUtil().setHeight(250),
      alignment: Alignment.center,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.homePageModel.quicks.length,
          itemBuilder: (context, index) {
            return Column(children: [
              Image.asset('assets${provider.homePageModel.quicks[index].image}',
                  width: ScreenUtil().setHeight(200),
                  height: ScreenUtil().setHeight(200)),
              Text('${provider.homePageModel.quicks[index].price}',
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

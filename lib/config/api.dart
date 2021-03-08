class Api {
  static const String _BASE_URL = "https://flutter-jdapi.herokuapp.com/api";
  // static const String _BASE_URL = 'http://192.168.0.231:5001/api';
  static const String HOME_PAGE = '$_BASE_URL/profiles/homepage'; // 首页数据
  static const String CATE_NAVI = '$_BASE_URL/profiles/navigationLeft'; // 分类导航
  static const String CATE_CONTENT =
      '$_BASE_URL/profiles/navigationRight'; // 导航类目
  static const String PROD_LIST = '$_BASE_URL/profiles/productionsList'; // 商品列表
  static const String PROD_DETAIL =
      '$_BASE_URL/profiles/productionDetail'; // 商品详情
}

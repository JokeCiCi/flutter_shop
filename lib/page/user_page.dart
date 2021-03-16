import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的')),
      body: ListView(
        children: <Widget>[
          // 头部
          _getUserHeader(),
          // 订单
          _getMyOrders(),
          // 资产
          _getMyproperty(),
          // 收藏
          _getCollection(),
        ],
      ),
    );
  }

  //顶部用户信息
  Widget _getUserHeader() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFE43B3A), Color(0xFFF07157)]),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 21, bottom: 50),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 36.0,
                  backgroundImage: AssetImage("assets/image/me-hl.png"),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "米修在线",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFFFDE5E3),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            margin: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.edit,
                              color: Colors.red,
                              size: 12.0,
                            ))
                      ],
                    ),
                    Text(
                      "用户名：hemiahwu",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFFFABBB7),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 2.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFC74A3D),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '京享值1774',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 2.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFC74A3D),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '小白信用99.6',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              height: 40,
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  )),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/image/ahv.png',
                    height: 25.0,
                    width: 25.0,
                  ),
                  Text(
                    'PLUS',
                    style: TextStyle(color: Colors.yellow, fontSize: 18.0),
                  ),
                  // Divider(color: Colors.yellow,),
                  Container(
                    height: 10,
                    width: 1.5,
                    color: Colors.yellow,
                    margin: EdgeInsets.all(8),
                  ),
                  Text(
                    '每月5张运费劵',
                    style: TextStyle(color: Colors.yellow, fontSize: 16.0),
                  ),
                  Spacer(),
                  Text(
                    '立即查看',
                    style: TextStyle(color: Colors.yellow, fontSize: 16.0),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.yellow,
                    size: 16,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //订单
  Widget _getMyOrders() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 50,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Icon(
                      Icons.payment,
                      color: Color(0xFFDB9D58),
                    )),
                Text('待付款', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.airport_shuttle,
                    color: Color(0xFFDB9D58),
                  )),
              Text('待收货', style: TextStyle(color: Colors.black54)),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.chat,
                    color: Color(0xFFDB9D58),
                  )),
              Text('待评价', style: TextStyle(color: Colors.black54)),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.monetization_on,
                    color: Color(0xFFDB9D58),
                  )),
              Text('退款/售后', style: TextStyle(color: Colors.black54)),
            ],
          ),
          Image.asset(
            "assets/image/ahv.png",
            width: 5.2,
            height: 44.0,
          ),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.featured_play_list,
                    color: Color(0xFFE51E1F),
                  )),
              Text('全部订单', style: TextStyle(color: Colors.black54)),
              Text('查看发票',
                  style: TextStyle(fontSize: 11, color: Colors.black12)),
            ],
          ),
        ],
      ),
    );
  }

  //资产
  Widget _getMyproperty() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '2',
                    style: TextStyle(fontSize: 22, color: Color(0xFFE8272B)),
                  ),
                  Text(
                    '张',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE8272B)),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '京东劵',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '0',
                    style: TextStyle(fontSize: 22, color: Color(0xFFE8272B)),
                  ),
                  Text(
                    '元',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE8272B)),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '账户余额',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '40',
                    style: TextStyle(fontSize: 22, color: Color(0xFFE8272B)),
                  ),
                  Text(
                    '个',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE8272B)),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '京豆',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '0',
                    style: TextStyle(fontSize: 22, color: Color(0xFFE8272B)),
                  ),
                  Text(
                    '元',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE8272B)),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '红包',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Image.asset(
            "assets/image/ahv.png",
            width: 5.2,
            height: 44.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Color(0xFFE51E1F),
                  )),
              Text('我的资产', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  //收藏
  Widget _getCollection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                '10',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '商品收藏',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '2',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '店铺收藏',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '0',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '搭配收藏',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '0',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '我的足迹',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

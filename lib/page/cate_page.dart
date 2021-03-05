import 'package:flutter/material.dart';

class CatePage extends StatelessWidget {
  const CatePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('分类')), body: Center(child: Text('分类')));
  }
}

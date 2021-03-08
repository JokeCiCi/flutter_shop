import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/product_page_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  final String title;
  const ProductPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductPageProvider>(
      create: (_) {
        var provider = ProductPageProvider();
        provider.loadProductModelListData();
      },
      child: Consumer<ProductPageProvider>(
        builder: (_, provider, __) {
          return Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  title: Text('$title')),
              body: Text('商品列表'));
        },
      ),
    );
  }
}

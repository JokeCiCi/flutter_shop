import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;
  const ProductDetailPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('hello world:${id}'),
    );
  }
}

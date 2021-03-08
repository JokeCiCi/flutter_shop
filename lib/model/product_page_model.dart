class ProductModelResp {
  int code;
  String msg;
  List<ProductModel> data;

  ProductModelResp({this.code, this.msg, this.data});

  ProductModelResp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<ProductModel>();
      json['data'].forEach((v) {
        data.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  String id;
  String cover;
  String title;
  String price;
  String comment;
  String rate;

  ProductModel(
      {this.id, this.cover, this.title, this.price, this.comment, this.rate});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'];
    title = json['title'];
    price = json['price'];
    comment = json['comment'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cover'] = this.cover;
    data['title'] = this.title;
    data['price'] = this.price;
    data['comment'] = this.comment;
    data['rate'] = this.rate;
    return data;
  }
}

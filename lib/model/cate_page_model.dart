class CateContentModelResp {
  int code;
  String msg;
  List<CateContentModel> data;

  CateContentModelResp({this.code, this.msg, this.data});

  CateContentModelResp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<CateContentModel>();
      json['data'].forEach((v) {
        data.add(new CateContentModel.fromJson(v));
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

class CateContentModel {
  String title;
  List<Desc> desc;

  CateContentModel({this.title, this.desc});

  CateContentModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['desc'] != null) {
      desc = new List<Desc>();
      json['desc'].forEach((v) {
        desc.add(new Desc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.desc != null) {
      data['desc'] = this.desc.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  String text;
  String img;

  Desc({this.text, this.img});

  Desc.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['img'] = this.img;
    return data;
  }
}

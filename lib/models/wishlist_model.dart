import 'package:ecommerce_mobile_app/models/product_model2.dart';

class WishlistModel {
  String? sId;
  ProductModel? productId;
  String? userId;
  int? iV;

  WishlistModel({this.sId, this.productId, this.userId, this.iV});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'] != null
        ? new ProductId.fromJson(json['productId'])
        : null;
    userId = json['userId'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    data['userId'] = this.userId;
    data['__v'] = this.iV;
    return data;
  }
}

class ProductId {
  String? sId;
  String? title;
  String? description;
  String? review;
  String? image;
  String? seller;
  int? price;
  String? category;
  double? rate;
  int? quandity;
  int? iV;

  ProductId(
      {this.sId,
      this.title,
      this.description,
      this.review,
      this.image,
      this.seller,
      this.price,
      this.category,
      this.rate,
      this.quandity,
      this.iV});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    review = json['review'];
    image = json['image'];
    seller = json['seller'];
    price = json['price'];
    category = json['category'];
    rate = json['rate'];
    quandity = json['quandity'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['review'] = this.review;
    data['image'] = this.image;
    data['seller'] = this.seller;
    data['price'] = this.price;
    data['category'] = this.category;
    data['rate'] = this.rate;
    data['quandity'] = this.quandity;
    data['__v'] = this.iV;
    return data;
  }
}

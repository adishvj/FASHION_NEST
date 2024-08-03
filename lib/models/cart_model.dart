import 'package:ecommerce_mobile_app/models/product_model2.dart';

class CartModel {
  String? sId;
  ProductModel? productId;
  String? userId;
  String? status;
  int? quantity;
  int? iV;

  CartModel(
      {this.sId,
      this.productId,
      this.userId,
      this.status,
      this.quantity,
      this.iV});

  CartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'] != null
        ? new ProductModel.fromJson(json['productId'])
        : null;
    userId = json['userId'];
    status = json['status'];
    quantity = json['quantity'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['quantity'] = this.quantity;
    data['__v'] = this.iV;
    return data;
  }
}

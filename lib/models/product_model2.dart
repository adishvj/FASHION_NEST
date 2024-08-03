class ProductModel {
  String? title;
  String? description;
  String? review;
  String? image;
  String? seller;
  int price = 0;
  String? category;
  double? rate;
  int quandity = 0;
  String? sId;
  int? iV;

  ProductModel(
      {required this.title,
      this.description,
      this.review,
      required this.image,
      this.seller,
      required this.price,
      this.category,
      this.rate,
      required this.quandity,
      this.sId,
      this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    review = json['review'];
    image = json['image'];
    seller = json['seller'];
    price = json['price'];
    category = json['category'];
    rate = json['rate'];
    quandity = json['quandity'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['review'] = this.review;
    data['image'] = this.image;
    data['seller'] = this.seller;
    data['price'] = this.price;
    data['category'] = this.category;
    data['rate'] = this.rate;
    data['quandity'] = this.quandity;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}

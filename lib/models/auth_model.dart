class AuthModel {
  String? username;
  String? password;
  String? name;
  String? phone;
  String? sId;
  int? iV;

  AuthModel(
      {this.username, this.password, this.name, this.phone, this.sId, this.iV});

  AuthModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name;
    data['phone'] = this.phone;
    // data['_id'] = this.sId;
    return data;
  }
}

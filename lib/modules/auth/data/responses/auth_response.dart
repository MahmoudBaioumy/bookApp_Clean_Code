class AuthResposne {
  Data? data;
  String? message;
  List<Null>? error;
  int? status;

  AuthResposne({this.data, this.message, this.error, this.status});

  AuthResposne.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    if (json['error'] != null) {
      error = <Null>[];
      json['error'].forEach((v) {
        error!.add((v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    if (this.error != null) {
      data['error'] = this.error!.map((v) => v).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  Userdata? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Userdata.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Userdata {
  int? id;
  String? name;
  String? email;
  String? city;
  String? phone;
  bool? emailVerified;
  String? image;

  Userdata({this.id, this.name, this.email, this.city, this.phone, this.emailVerified, this.image});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    city = json['city'];
    phone = json['phone'];
    emailVerified = json['email_verified'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['email_verified'] = this.emailVerified;
    data['image'] = this.image;
    return data;
  }
}

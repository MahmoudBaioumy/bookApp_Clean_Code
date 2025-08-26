class GetProfileResponse {
  profileData? data;
  String? message;
  List<String>? error;
  int? status;

  GetProfileResponse({this.data, this.message, this.error, this.status});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new profileData.fromJson(json['data']) : null;
    message = json['message'];
    if (json['error'] != null) {
      error = <String>[];
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

class profileData {
  int? id;
  String? name;
  String? email;
  String? address;
  String? city;
  String? phone;
  bool? emailVerified;
  String? image;

  profileData(
      {this.id,
        this.name,
        this.email,
        this.address,
        this.city,
        this.phone,
        this.emailVerified,
        this.image});

  profileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
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
    data['address'] = this.address;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['email_verified'] = this.emailVerified;
    data['image'] = this.image;
    return data;
  }
}

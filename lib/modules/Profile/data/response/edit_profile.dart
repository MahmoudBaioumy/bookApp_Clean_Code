import '../../../auth/data/responses/auth_response.dart';

class EditProfile {
  Userdata? data;
  String? message;
  List<Null>? error;
  int? status;

  EditProfile({this.data, this.message, this.error, this.status});

  EditProfile.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Userdata.fromJson(json['data']) : null;
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

class DefaultResponse {
  int? status;
  String? message;

  DefaultResponse({this.status, this.message});

  DefaultResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
class DefaultPripoResponse2 {
  bool? status;
  String? message;

  DefaultPripoResponse2({this.status, this.message});

  DefaultPripoResponse2.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = message;
    return data;
  }
}

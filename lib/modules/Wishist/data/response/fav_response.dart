// favorite_response.dart
class FavoriteResponse {
  List<FavData>? data; // List of books
  String? message;
  List<dynamic>? error;
  int? status;

  FavoriteResponse({this.data, this.message, this.error, this.status});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    List<FavData> books = [];

    // تحقق من وجود البيانات داخل json['data']['data']
    if (json['data'] != null && json['data']['data'] != null) {
      json['data']['data'].forEach((v) {
        books.add(FavData.fromJson(v));
      });
    }

    return FavoriteResponse(
      data: books,
      message: json['message'] ?? '',
      error: json['error'] != null ? List.from(json['error']) : [],
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {'data': data?.map((v) => v.toJson()).toList()},
      'message': message,
      'error': error,
      'status': status,
    };
  }
}

class FavData {
  int? id;
  String? name;
  String? price;
  String? category;
  String? image;
  int? discount;
  int? stock;
  String? description;
  int? bestSeller;

  FavData({
    this.id,
    this.name,
    this.price,
    this.category,
    this.image,
    this.discount,
    this.stock,
    this.description,
    this.bestSeller,
  });

  factory FavData.fromJson(Map<String, dynamic> json) {
    return FavData(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
      discount: json['discount'],
      stock: json['stock'],
      description: json['description'],
      bestSeller: json['best_seller'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'discount': discount,
      'stock': stock,
      'description': description,
      'best_seller': bestSeller,
    };
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

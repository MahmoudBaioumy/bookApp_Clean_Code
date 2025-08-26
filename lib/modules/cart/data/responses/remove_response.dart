class RemoveCartResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  RemoveCartResponse({this.data, this.message, this.error, this.status});

  RemoveCartResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
      message = json['message'];
      error = json['error'] != null ? List.from(json['error']) : [];
      status = json['status'];
    } else if (json is List) {
      // لو رجع List مباشرة
      data = Data(cartItems: json.map((e) => CartItemsRemove.fromJson(e)).toList());
      message = "Success";
      error = [];
      status = 200;
    } else {
      data = null;
      message = "Unexpected response";
      error = [];
      status = -1;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    dataMap['message'] = message;
    if (error != null) {
      dataMap['error'] = error!.map((v) => v).toList();
    }
    dataMap['status'] = status;
    return dataMap;
  }
}

class Data {
  int? id;
  User? user;
  double? total;
  List<CartItemsRemove>? cartItems;

  Data({this.id, this.user, this.total, this.cartItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    total = (json['total'] != null) ? (json['total'] as num).toDouble() : null;
    if (json['cart_items'] != null) {
      cartItems = <CartItemsRemove>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItemsRemove.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    if (user != null) {
      dataMap['user'] = user!.toJson();
    }
    dataMap['total'] = total;
    if (cartItems != null) {
      dataMap['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

class User {
  int? userId;
  String? userName;

  User({this.userId, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
    };
  }
}

class CartItemsRemove {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  double? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  double? itemTotal;

  CartItemsRemove({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity,
    this.itemTotal,
  });

  CartItemsRemove.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemProductId = json['item_product_id'];
    itemProductName = json['item_product_name'];
    itemProductImage = json['item_product_image'];
    itemProductPrice = json['item_product_price'];
    itemProductDiscount = json['item_product_discount'];
    itemProductPriceAfterDiscount =
    (json['item_product_price_after_discount'] != null)
        ? (json['item_product_price_after_discount'] as num).toDouble()
        : null;
    itemProductStock = json['item_product_stock'];
    itemQuantity = json['item_quantity'];
    itemTotal = (json['item_total'] != null)
        ? (json['item_total'] as num).toDouble()
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'item_product_id': itemProductId,
      'item_product_name': itemProductName,
      'item_product_image': itemProductImage,
      'item_product_price': itemProductPrice,
      'item_product_discount': itemProductDiscount,
      'item_product_price_after_discount': itemProductPriceAfterDiscount,
      'item_product_stock': itemProductStock,
      'item_quantity': itemQuantity,
      'item_total': itemTotal,
    };
  }
}

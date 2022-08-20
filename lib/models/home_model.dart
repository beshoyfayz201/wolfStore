class HomeModel {
  late bool status;
  late HomeDataModel homeDataModel;
  HomeModel({
    required this.status,
    required this.homeDataModel,
  });

  HomeModel.formMap(Map<String, dynamic> map) {
    status = map["status"] ?? false;

    homeDataModel = HomeDataModel.fromMap(map['data']);
  }
}

class HomeDataModel {
  late List<BannerModel> banners = [];
  late List<ProductModel> products = [];

  HomeDataModel.fromMap(Map<String, dynamic> map) {
    map['banners'].forEach((e) {
      banners.add(BannerModel.fromMap(e));
    });
    map['products'].forEach((e) {
      print("eeeeeeeeeeeeeeeeeeeeee\n");
      print(e);
      products.add(ProductModel.fromMap(e));
    });
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel({
    required this.id,
    required this.image,
  });

  BannerModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    image = map['image'];
  }
}

class ProductModel {
  dynamic? price;
  dynamic? oldPrice;
  int? id;
  dynamic? discount;
  String? image;
    String? name;
  String? description;

  bool? isFavorite;
  bool? inCart;

  ProductModel({
    this.price,
    this.oldPrice,
    this.id,
    this.discount,
    this.image,
    this.isFavorite,
    this.inCart,
    this.name,
    this.description
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      price: map['price'],
      oldPrice: map['old_price'],
      id: map['id']?.toInt(),
      discount: map['discount'],
      image: map['image'],
      isFavorite: map['in_favorites'],
      inCart: map['in_cart'],
      name:map['name'],
      description:map['description']
    );
  }
}

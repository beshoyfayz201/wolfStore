class CategoryModel {
  bool? status;

  CategoryData? categoryData;

  CategoryModel.fromMap(Map<String, dynamic> map) {
    status = map["status"];
    categoryData = CategoryData.fromMap(map['data']);
  }
}

class CategoryData {
  int? currentPage;
  List<dynamic> categoryDataItem = [];
  CategoryData.fromMap(Map<String, dynamic> map) {
    currentPage = map['current_page'];
    map["data"].forEach((e) {
      categoryDataItem.add(CategoryDataItem.fromMap(e));
    });
  }
}

class CategoryDataItem {
  int? id;
  String? name;
  String? image;

  CategoryDataItem.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    image = map['image'];
  }
}

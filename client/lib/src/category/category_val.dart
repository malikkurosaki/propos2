import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryVal {
  static final listCompanyCreate = [].obs;
  static final listCompanyDisplay = [].obs;
  static final bodyCreate = {}.val("CategoryVal.name3").obs;
  static final listCategory = [].val("CategoryVal.listCategory").obs;
  static final reload = false.obs;

  // static final bodyUpdate = CategoryModel().obs;

  static final mapData = {}.obs;
}

class CategoryModel {
  String? id;
  String? name;

  CategoryModel({this.id, this.name});

  CategoryModel.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
  }

  Map toJson() {
    final data = {};
    data['id'] = id;
    data['name'] = name;

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

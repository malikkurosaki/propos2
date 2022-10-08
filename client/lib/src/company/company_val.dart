import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompanyVal {
  static final listCompany = [].val("Company.listCompany").obs;
  static final bodyCreate = CompanyModel().obs;
  static final reload = false.obs;

  static final mapData = {}.obs;
}

class CompanyModel {
  String? id;
  String? name;
  String? address;
  String? logoUrl;
  String? phone;

  CompanyModel({
    this.id,
    this.name,
    this.address,
    this.logoUrl,
    this.phone,
  });

  CompanyModel.froJson(Map json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    logoUrl = json['logoUrl'];
    phone = json['phone'];
  }

  Map toJson() {
    final data = {};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['logoUrl'] = logoUrl;
    data['phone'] = phone;

    return data;
  }
}

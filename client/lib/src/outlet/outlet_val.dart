import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OutletVal {
  static final listCompany = [].obs;
  static final bodyCreate = OutletModel().obs;
  static final bodyUpdate = OutletModel().obs;
  static String companyId = "";
  static final listoutlet = [].val('OutletVal.listOutlet').obs;
}

class OutletModel {
  String? id;
  String? name;
  String? address;
  String? companyId;
  String? email;
  String? phone;
  String? logoUrl;
  String? userId;

  OutletModel({
    this.id,
    this.name,
    this.address,
    this.companyId,
    this.email,
    this.phone,
    this.logoUrl,
    this.userId,
  });

  OutletModel.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    companyId = json['companyId'];
    email = json['email'];
    phone = json['phone'];
    logoUrl = json['logoUrl'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['companyId'] = companyId;
    data['email'] = email;
    data['phone'] = phone;
    data['logoUrl'] = logoUrl;
    data['userId'] = userId;
    // data.removeWhere((key, value) => value.toString().isEmpty || value == null);
    return data;
  }
}

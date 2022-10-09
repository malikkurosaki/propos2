import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/customer/customer_val.dart';
import 'package:recase/recase.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CustomerCreate extends StatelessWidget {
  CustomerCreate({Key? key}) : super(key: key);

  final listBody = {
    "name": "",
    "address": "",
    "phone": "",
    "email": "",
    // "companyId": "",
    // "userId": "",
    "whatsapp": "",
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "Create Customer",
            style: TextStyle(fontSize: 18),
          ),
        ),
        ListTile(
          title: Column(
            children: [
              FutureBuilder<http.Response>(
                future: Rot.customerListCompanyGet(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) return LinearProgressIndicator();
                  debugPrint(snapshot.data!.body);
                  final data = jsonDecode(snapshot.data!.body);
                  Future.delayed(Duration(microseconds: 100), () => CustomerVal.listCompanyCreate.assignAll(data));
                  return SizedBox.shrink();
                },
              ),
              Obx(
                () => DropdownSearch<Map>(
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration:
                        InputDecoration(filled: true, border: InputBorder.none, hintText: 'select company'),
                  ),
                  items: [...CustomerVal.listCompanyCreate],
                  itemAsString: (value) => value['name'].toString(),
                  onChanged: (value) {
                    CustomerVal.selectedCompany.assignAll(value!);
                  },
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView(
            children: [
              ...listBody.keys.map(
                (e) => ListTile(
                  title: TextFormField(
                    onChanged: (value) => listBody[e] = value,
                    controller: TextEditingController(text: listBody[e]),
                    decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      labelText: e.toString().titleCase,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (listBody['name'].toString().isEmpty) {
                      SmartDialog.showToast("no empty name");
                      return;
                    }

                    if (CustomerVal.selectedCompany.isEmpty) {
                      SmartDialog.showToast("please select company");
                      return;
                    }

                    listBody['companyId'] = CustomerVal.selectedCompany['id'];
                    listBody.removeWhere((key, value) => value.toString().isEmpty);

                    final data = await Rot.customerCreatePost(body: {"data": jsonEncode(listBody)});
                    if (data.statusCode == 201) {
                      SmartDialog.showToast("success");
                      CustomerVal.reload.toggle();
                      return;
                    }

                    SmartDialog.showToast(data.body);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

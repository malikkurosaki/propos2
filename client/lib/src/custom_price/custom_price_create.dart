import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/components/input.dart';
import 'package:get/get.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/custom_price/custom_price_val.dart';
import 'package:propos/utils/notif.dart';
import 'package:http/http.dart' as http;

class CustomPriceCreate extends StatelessWidget {
  CustomPriceCreate({Key? key}) : super(key: key);
  // final conName = TextEditingController();
  final loadingbutton = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Create Custom Price"),
              ),
              ListTile(
                title: Column(
                  children: [
                    FutureBuilder<http.Response>(
                      future: Rot.customPriceListCompanyGet(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) return LinearProgressIndicator();
                        final List lsData = jsonDecode(snapshot.data!.body);
                        Future.delayed(Duration(microseconds: 100), () => CustomPriceVal.listCompany.assignAll(lsData));
                        return SizedBox.shrink();
                      },
                    ),
                    Obx(
                      () => DropdownSearch<Map>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            filled: true,
                            hintText: 'Select Company',
                            border: InputBorder.none,
                          ),
                        ),
                        items: [...CustomPriceVal.listCompany],
                        itemAsString: (value) => value['name'],
                        onChanged: (value) {
                          CustomPriceVal.selectedCompany.assignAll(value!);
                        },
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                title: TextFormField(
                  onChanged: ((value) => CustomPriceVal.name.value = value),
                  controller: TextEditingController(text: CustomPriceVal.name.value),
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Name',
                  ),
                ),
              ),
              // Input(
              //   controller: conName,
              //   label: "name",
              // ),
              ListTile(
                title: Obx(
                  () => loadingbutton.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : MaterialButton(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            loadingbutton.value = true;
                            Future.delayed(Duration(seconds: 2), () {
                              loadingbutton.value = false;
                            });

                            final body = {
                              "companyId": CustomPriceVal.selectedCompany['id'],
                              "name": CustomPriceVal.name.value
                            };

                            if (body.values.contains("")) {
                              Notif.error(message: "name tidak boleh kosong");
                              return;
                            }

                            // debugPrint(body.toString());
                            final data = await Rot.customPriceCreatePost(body: {"data": jsonEncode(body)});

                            if (data.statusCode == 201) {
                              SmartDialog.showToast("Success");
                              CustomPriceVal.reeload.toggle();
                              return;
                            }

                            Notif.error(message: data.body.toString());
                          },
                        ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

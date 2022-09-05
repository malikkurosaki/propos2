import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:propos/components/input.dart';
import 'package:propos/components/company_multi_select.dart';
import 'package:propos/components/save_button.dart';
import 'package:propos/components/search_view.dart';
import 'package:propos/utils/notif.dart';
import 'package:propos/utils/router_api.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class Customer extends StatelessWidget {
  Customer({Key? key}) : super(key: key);
  final _listCustomer = [].obs;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Column(
                        children: [
                          Flexible(child: _listDisplay()
                              // Column(
                              //   children: [
                              //     ListTile(
                              //       leading: Checkbox(
                              //         value: false,
                              //         onChanged: (value) {},
                              //       ),
                              //       title: SearchView(
                              //         onChanged: (value) {
                              //           debugPrint(value.toString());
                              //         },
                              //       ),
                              //     ),
                              //     Flexible(child: ),
                              //   ],
                              // ),
                              ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !media.isMobile,
                    child: SizedBox(
                      width: 360,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Create Customer",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListView(
                                children: [_create()],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  _loadCustomer() async {
    RouterApi.custoemerGetList().getData().then((value) {
      if (value.statusCode == 200) {
        _listCustomer.assignAll(jsonDecode(value.body));
      }
    });
  }

  Widget _listDisplay() {
    final listSelected = [].obs;
    _loadCustomer();
    return Obx(
      () => Column(
        children: [
          ListTile(
            leading: Checkbox(
              value: _listCustomer.isNotEmpty && _listCustomer.length.isEqual(listSelected.length),
              onChanged: (value) {
                if (value!) {
                  listSelected.assignAll(_listCustomer.map((element) => element['id']));
                } else {
                  listSelected.clear();
                }
              },
            ),
            title: SearchView(
              onChanged: (value) {
                debugPrint(value.toString());
              },
            ),
          ),
          Flexible(
            child: ListView(
              children: [
                ..._listCustomer.map((element) => ListTile(
                      leading: Checkbox(
                        value: listSelected.contains(element['id']),
                        onChanged: (value) {
                          if (value!) {
                            listSelected.add(element['id']);
                          } else {
                            listSelected.removeWhere((e) => e == element['id']);
                          }
                        },
                      ),
                      title: Text(element['name'].toString()),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Edit"),
                            value: 'edit',
                          ),
                          PopupMenuItem(
                            child: Text('Delete'),
                            value: 'delete',
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _create() {
    final body = {
      "name": "",
      "address": "",
      "phone": "",
      "email": "",
      "whatsapp": "",
    }.val("Customer.create.body");
    final listCompanyId = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompanyMultiSelect(onSelectCompany: (value) {
          listCompanyId.assignAll(value);
        }),
        Input(text: body.val['name'], label: "Name", onChanged: (value) => body.val['name'] = value),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "* optional",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Input(text: body.val['email'], label: 'Email', onChanged: (value) => body.val['email'] = value),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "* optional",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Input(text: body.val['address'], label: 'Address', onChanged: (value) => body.val['address'] = value),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "* optional",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Input(text: body.val['phone'], label: 'Whatsapp', onChanged: (value) => body.val['phone'] = value),
        SaveButton(
          onPressed: () async {
            if (listCompanyId.isEmpty || body.val['name'].toString().isEmpty) {
              Notif.error(message: "company dan nama tidak boleh kosong");
            }

            final bd = <String, String>{"listCompany": jsonEncode(listCompanyId), "body": jsonEncode(body.val)};

            final data = await RouterApi.customerCreate().postData(bd);
            if (data.statusCode == 201) {
              _loadCustomer();
            } else {
              Notif.error();
            }
          },
        )
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:propos/components/multi_select_outlet_bycompany.dart';
import 'package:propos/components/select_company.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/val_def.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({Key? key}) : super(key: key);
  final _selectValue = "".obs;
  final _listPaymentMethod = [].obs;
  final _companyId = "".obs;

  _onLoad() async {
    final data = await RouterApi.paymentMethodList().getData();
    if (data.statusCode == 200) _listPaymentMethod.assignAll(jsonDecode(data.body));
    // ValDef.paymentMethodList.value.val = jsonDecode(data);
    // await 0.1.delay();
    // ValDef.paymentMethodList.refresh();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Obx(
                                () => ListView(
                                  children: [
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: media.isMobile,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(
                                              onPressed: () {
                                                Get.dialog(SimpleDialog(
                                                  children: [_create(media)],
                                                ));
                                              },
                                              icon: Icon(
                                                Icons.add_circle,
                                                color: Colors.cyan,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      leading: Checkbox(value: false, onChanged: (value) {}),
                                      title: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          ),
                                          border: OutlineInputBorder(borderSide: BorderSide.none),
                                          filled: true,
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    for (final itm in _listPaymentMethod)
                                      ListTile(
                                        leading: Checkbox(value: false, onChanged: (value) {}),
                                        title: Text(itm['name'].toString()),
                                        trailing: PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Text("Edit"),
                                              value: "edit",
                                            ),
                                            PopupMenuItem(
                                              child: Text("Delete"),
                                              value: "delete",
                                            ),
                                          ],
                                        ),
                                      )
                                    // _selectValue.value == itm['id']
                                    //     ? Builder(
                                    //         builder: (context) {
                                    //           final conName = TextEditingController(text: itm['name']);
                                    //           return
                                    //           ListTile(
                                    //             leading: IconButton(
                                    //               onPressed: () {
                                    //                 _selectValue.value = "";
                                    //               },
                                    //               icon: Icon(
                                    //                 Icons.close,
                                    //                 color: Colors.pink,
                                    //               ),
                                    //             ),
                                    //             title: TextFormField(
                                    //               controller: conName,
                                    //               decoration: InputDecoration(
                                    //                 labelText: "Nama",
                                    //                 filled: true,
                                    //                 border: OutlineInputBorder(
                                    //                   borderSide: BorderSide.none,
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //             trailing: IconButton(
                                    //               onPressed: () {},
                                    //               icon: Icon(
                                    //                 Icons.save,
                                    //                 color: Colors.cyan,
                                    //               ),
                                    //             ),
                                    //           );
                                    //         },
                                    //       )
                                    //     : ListTile(
                                    //         leading: IconButton(
                                    //           onPressed: () {
                                    //             _selectValue.value = itm['id'];
                                    //           },
                                    //           icon: Icon(
                                    //             Icons.edit,
                                    //             color: Colors.cyan,
                                    //           ),
                                    //         ),
                                    //         title: Text(
                                    //           itm['name'],
                                    //         ),
                                    //         trailing: IconButton(
                                    //           onPressed: () {},
                                    //           icon: Icon(
                                    //             Icons.delete,
                                    //             color: Colors.red,
                                    //           ),
                                    //         ),
                                    //       )
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //     itm['name'],
                                    //     style: TextStyle(
                                    //       fontSize: 24,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !media.isMobile,
                      child: Card(child: _create(media)),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _create(SizingInformation media) => Container(
        color: Colors.white,
        width: media.isMobile ? Get.width : 360,
        height: media.isMobile ? 360 : Get.height * 0.92,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Create Payment Method",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Form(
                    child: Builder(
                      builder: (context) {
                        final conName = TextEditingController();
                        return Column(
                          children: [
                            SelectCompany(
                              onSelectCompany: (value) {
                                _companyId.value = value.toString();
                              },
                            ),
                            Obx(
                              () => MultiSelectOutletBycompany(companyId: _companyId.value, onSelectOutlet: (value) {}),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: conName,
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                color: Colors.cyan,
                                onPressed: () async {
                                  final body = {
                                    "companyId": _companyId.value,
                                    "name": conName.text,
                                  };

                                  final crt = await RouterApi.paymentMethodCreate().postData(body);
                                  await _onLoad();
                                  if (media.isMobile) {
                                    Get.back();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      "Create",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}

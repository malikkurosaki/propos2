import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/components/select_customer.dart';
import 'package:get/get.dart';
import 'package:propos/src/cashier/cashier_add_customer.dart';
import 'package:propos/utils/router_api.dart';

class CashierAdditional extends StatelessWidget {
  CashierAdditional({Key? key}) : super(key: key);
  final _conPax = TextEditingController(text: "1");
  final _pax = "0".obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: MaterialButton(
        color: Colors.green,
        child: Text(
          "Additional",
          style: TextStyle(color: Colors.white),
        ),
        // icon: Icon(Icons.keyboard_arrow_up_rounded),
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (c) => Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              BackButton(
                                color: Colors.white,
                              ),
                              Text(
                                "Additional",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          color: Colors.white,
                          onPressed: () {},
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SelectCustomer(
                          onChanged: (id) {
                            debugPrint(id);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                titlePadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                content: CashierAddCustomer()
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   mainAxisSize: MainAxisSize.min,
                                //   children: [
                                //     Row(
                                //       children: [BackButton(), Text("Add Customer")],
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: TextFormField(
                                //         decoration: InputDecoration(
                                //           filled: true,
                                //           isDense: true,
                                //           hintText: "Name",
                                //           border: OutlineInputBorder(borderSide: BorderSide.none),
                                //         ),
                                //       ),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: TextFormField(
                                //         decoration: InputDecoration(
                                //           filled: true,
                                //           isDense: true,
                                //           hintText: "Phone Number",
                                //           border: OutlineInputBorder(borderSide: BorderSide.none),
                                //         ),
                                //       ),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: TextFormField(
                                //         decoration: InputDecoration(
                                //           filled: true,
                                //           isDense: true,
                                //           hintText: "Email",
                                //           border: OutlineInputBorder(borderSide: BorderSide.none),
                                //         ),
                                //       ),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: TextFormField(
                                //         decoration: InputDecoration(
                                //           filled: true,
                                //           isDense: true,
                                //           hintText: "Address",
                                //           border: OutlineInputBorder(borderSide: BorderSide.none),
                                //         ),
                                //       ),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: TextFormField(
                                //         decoration: InputDecoration(
                                //           filled: true,
                                //           isDense: true,
                                //           hintText: "Sex",
                                //           border: OutlineInputBorder(borderSide: BorderSide.none),
                                //         ),
                                //       ),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: MaterialButton(
                                //         color: Colors.blue,
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(10.0),
                                //           child: Center(
                                //             child: Text(
                                //               "Save",
                                //               style: TextStyle(color: Colors.white, fontSize: 16),
                                //             ),
                                //           ),
                                //         ),
                                //         onPressed: () {},
                                //       ),
                                //     )
                                //   ],
                                // ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add_box,
                            color: Colors.cyan,
                          ),
                        ),
                      )
                    ],
                  ),
                  Obx(
                    () => ListTile(
                      leading: IconButton(
                        onPressed: () {
                          final angka = int.tryParse(_conPax.text);
                          if (int.tryParse(_conPax.text) == null) {
                            _conPax.text = "1";
                          }
                          if (angka != null && angka > 1) {
                            _conPax.text = (angka - 1).toString();
                          }
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.orange,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          if (int.tryParse(_conPax.text) == null) {
                            _conPax.text = "0";
                          }
                          _conPax.text = (int.parse(_conPax.text) + 1).toString();
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        ),
                      ),
                      title: Text("Pax"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              if (int.tryParse(value) == null) {
                                _conPax.clear();
                                _conPax.text = "";
                              }

                              _pax.value = value;
                            },
                            controller: _conPax,
                            decoration: InputDecoration(
                              filled: true,
                              isDense: true,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          ),
                          Text(int.tryParse(_pax.value) == null ? "Number Only" : "")
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(
                      builder: (context) {
                        final lsDiscount = [].obs;
                        RouterApi.discountList().getData().then((res) {
                          if (res.statusCode == 200) lsDiscount.assignAll(jsonDecode(res.body));
                        });
                        return Obx(
                          () => DropdownButtonFormField(
                            decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                hintText: "Select Discount",
                                border: OutlineInputBorder(borderSide: BorderSide.none)),
                            items: [
                              ...lsDiscount.map(
                                (element) => DropdownMenuItem(
                                  value: element,
                                  child: Text(element['name']),
                                ),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        );
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text("Discount"),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text("Tax"),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

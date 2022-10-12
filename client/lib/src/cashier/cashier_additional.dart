import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/components/select_customer.dart';
import 'package:get/get.dart';
import 'package:propos/src/cashier/cashier_add_customer.dart';
import 'package:propos/src/cashier/cashier_select_customer.dart';
import 'package:propos/src/cashier/cashier_select_discount.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/router_api.dart';

class CashierAdditional extends StatelessWidget {
  const CashierAdditional({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: MaterialButton(
        color: Colors.green,
        child: SizedBox(
          width: 100,
          child: Center(
            child: Text(
              "Additional",
              style: TextStyle(color: Colors.white),
            ),
          ),
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
                          onPressed: () {
                            Get.back();
                          },
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
                      Expanded(child: CashierSelectCutomer()
                          // SelectCustomer(
                          //   onChanged: (id) {
                          //     debugPrint(id);
                          //   },
                          // ),
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
                          CashierVal.pax.value.val -= 1;
                          if (CashierVal.pax.value.val < 1) {
                            CashierVal.pax.value.val = 1;
                          }

                          CashierVal.pax.refresh();
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.orange,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          CashierVal.pax.value.val += 1;
                          CashierVal.pax.refresh();
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        ),
                      ),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Pax"),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  onChanged: (value) {
                                    if (int.tryParse(value) == null) {
                                      CashierVal.pax.value.val = 1;
                                    }

                                    CashierVal.pax.value.val = int.parse(value);
                                    CashierVal.pax.refresh();
                                  },
                                  controller: TextEditingController(text: CashierVal.pax.value.val.toString()),
                                  decoration: InputDecoration(
                                    filled: true,
                                    isDense: true,
                                    border: OutlineInputBorder(borderSide: BorderSide.none),
                                  ),
                                ),
                                // Text(int.tryParse(CashierVal.pax.value.toString()) == null ? "Number Only" : "")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // CashierSelectDiscount()
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Builder(
                  //     builder: (context) {
                  //       final lsDiscount = [].obs;
                  //       RouterApi.discountList().getData().then(
                  //         (res) {
                  //           if (res.statusCode == 200) lsDiscount.assignAll(jsonDecode(res.body));
                  //         },
                  //       );
                  //       return Obx(
                  //         () => DropdownButtonFormField(
                  //           decoration: InputDecoration(
                  //               filled: true,
                  //               isDense: true,
                  //               hintText: "Select Discount",
                  //               border: OutlineInputBorder(borderSide: BorderSide.none)),
                  //           items: [
                  //             ...lsDiscount.map(
                  //               (element) => DropdownMenuItem(
                  //                 value: element,
                  //                 child: Text(element['name']),
                  //               ),
                  //             ),
                  //           ],
                  //           onChanged: (value) {},
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/src/cashier/cashier_additional.dart';
import 'package:propos/src/cashier/cashier_manual_order.dart';
import 'package:propos/src/cashier/cashier_menu_item.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CashierTotalanHeader extends StatelessWidget {
  const CashierTotalanHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Obx(
        () => Ink(
          color: Colors.grey.shade200,
          child: ListTile(
            leading: Tooltip(
              message: "Select Sekaligus",
              child: Checkbox(
                value: Val.listorder.value.val.isNotEmpty &&
                    CashierVal.lsTampungan.length.isEqual(Val.listorder.value.val.length),
                onChanged: Val.listorder.value.val.isEmpty
                    ? null
                    : (value) {
                        if (value!) {
                          CashierVal.lsTampungan.assignAll(Val.listorder.value.val.map((e) => e['id']));
                        } else {
                          CashierVal.lsTampungan.clear();
                        }

                        if (media.isMobile) Get.back();
                      },
              ),
            ),
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              children: [
                CashierManualOrder(),
                CashierAdditional(),
                Visibility(
                  visible: CashierVal.lsTampungan.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: MaterialButton(
                      elevation: 0,
                      color: Colors.orange,
                      child: SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: Text("Clean Order"),
                            content: Text("Are you sure to delete order?"),
                            actions: [
                              MaterialButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: MaterialButton(
                                  child: Text("Delete"),
                                  onPressed: () {
                                    final lsTmp = List.from(Val.listorder.value.val);
                                    lsTmp.removeWhere((element) => CashierVal.lsTampungan.contains(element['id']));
                                    Val.listorder.value.val = lsTmp;
                                    CashierVal.lsTampungan.clear();
                                    Val.listorder.refresh();
                                    Get.back();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Visibility(
                //   visible: media.isMobile,
                //   child: Padding(
                //     padding: const EdgeInsets.all(2),
                //     child: MaterialButton(
                //       color: Colors.blue,
                //       onPressed: () {
                //         Get.dialog(
                //           Dialog(
                //             insetPadding: EdgeInsets.all(8),
                //             child: Material(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Row(
                //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Padding(
                //                         padding: const EdgeInsets.all(8.0),
                //                         child: BackButton(),
                //                       ),
                //                       Padding(
                //                         padding: const EdgeInsets.all(8.0),
                //                         child: Text("Select Item"),
                //                       )
                //                     ],
                //                   ),
                //                   // Flexible(child: listMenuItem(media)),
                //                   Flexible(child: CashierMenuItem()),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //       child: SizedBox(
                //         width: 100,
                //         child: Center(
                //           child: Text(
                //             "Add",
                //             style: TextStyle(
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
            trailing: !media.isMobile
                ? null
                : InkWell(
                    onTap: () {
                      showBottomSheet(context: context, builder: (context) => Material(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: BackButton(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Select Item"),
                                        )
                                      ],
                                    ),
                                    // Flexible(child: listMenuItem(media)),
                                    Flexible(child: CashierMenuItem()),
                                  ],
                                ),
                              ));
                    },
                    child: Icon(
                      Icons.add_box_rounded,
                      color: Colors.blue,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

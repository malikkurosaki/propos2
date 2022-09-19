import 'package:flutter/material.dart';
import 'package:propos/components/select_customer.dart';
import 'package:propos/src/cashier/cashier_additional.dart';
import 'package:propos/src/cashier/cashier_manual_order.dart';
import 'package:propos/src/cashier/cashier_menu_item.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    tooltip: "menghapus multiple",
                    onPressed: CashierVal.lsTampungan.isEmpty
                        ? null
                        : () {
                            Get.dialog(AlertDialog(
                              title: Text("Clean Order"),
                              content: Text("Are you sure to delete order?"),
                              actions: [
                                MaterialButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                MaterialButton(
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
                              ],
                            ));
                          },
                    icon: Icon(
                      Icons.delete_sweep_sharp,
                      color: CashierVal.lsTampungan.isEmpty ? Colors.grey : Colors.pink,
                    ),
                  ),
                )
              ],
            ),
            trailing: Visibility(
              visible: media.isMobile,
              child: IconButton(
                tooltip: "tambah item order",
                onPressed: () {
                  Get.dialog(
                    Dialog(
                      insetPadding: EdgeInsets.all(8),
                      child: Material(
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
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.add_circle_outlined,
                  size: 36,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/components/select_customer.dart';
import 'package:propos/src/cashier/cashier_menu_item.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class CashierTotalanHeader extends StatelessWidget {
  const CashierTotalanHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) => 
    Ink(
          color: Colors.grey.shade200,
          child: ListTile(
            leading: Tooltip(
              message: "Select Sekaligus",
              child: Checkbox(
                value: Val.listorder.value.val.isNotEmpty && CashierVal.lsTampungan.length.isEqual(Val.listorder.value.val.length),
                onChanged: Val.listorder.value.val.isEmpty
                    ? null
                    : (value) {
                        if (value!) {
                          CashierVal.lsTampungan.assignAll(Val.listorder.value.val.map((e) => e['id']));
                        } else {
                          CashierVal.lsTampungan.clear();
                        }
                        Get.back();
                      },
              ),
            ),
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              children: [
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
                ),
                MaterialButton(
                  color: Colors.orange,
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (c) {
                        return Material(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [BackButton(), Text("Manual Order")],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    "Manual Order",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
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
                        builder: (c) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [BackButton(), Text("Additional")],
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
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add_box,
                                        color: Colors.cyan,
                                      )),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Discount"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Tax"),
                            ),
                          ],
                        ),
                      );
                    },
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
        ));
  }
}
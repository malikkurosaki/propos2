import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/pages.dart';
import 'package:propos/src/cashier/cashier_dialog_save.dart';
import 'package:propos/src/cashier/cashier_menu_item.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CashierTotalanFooter extends StatelessWidget {
  const CashierTotalanFooter({Key? key}) : super(key: key);

  Widget _saveOrderButton(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: Val.listorder.value.val.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(right: 4, top: 4),
          child: MaterialButton(
            color: Colors.cyan,
            onPressed: Val.listorder.value.val.isEmpty
                ? null
                : () {
                    // _savedOrderDialog(context);
                    CashierDialogSave.now(context);
                  },
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 24,
                  ),
                  Text(
                    "Save",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Visibility(
                    visible: media.isMobile,
                    child: Container(
                     padding: const EdgeInsets.only(right: 4),
                      child: MaterialButton(
                        color: Colors.green,
                        onPressed: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) => Material(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(8.0),
                                  //       child: BackButton(),
                                  //     ),
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(8.0),
                                  //       child: Text("Select Item"),
                                  //     )
                                  //   ],
                                  // ),
                                  // Flexible(child: listMenuItem(media)),
                                  ListTile(
                                    leading: BackButton(),
                                    title: Text("Select Item", style: TextStyle(fontSize: 18),),
                                  ),
                                  Flexible(child: CashierMenuItem()),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                              Text(
                                "Add Item",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  _saveOrderButton(context),
                ],
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        Text(
                          "Checkout",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    if (Val.listorder.value.val.isNotEmpty) {
                      Get.toNamed(Pages.checkoutPage().route);
                    } else {
                      Get.dialog(
                        AlertDialog(
                          title: Text("Warning"),
                          content: Text("Please add item to cart"),
                          actions: [
                            MaterialButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

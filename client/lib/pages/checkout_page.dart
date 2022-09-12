import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/components/struk.dart';
import 'package:propos/pages.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  // final _toPay = "0".val("CheckoutPage.haveToPay2").obs;
  // final _listHotKey = ["1000", "5000", "10000", "20000", "50000", "100000", "uang pas"];
  // final _totalPrice = Val.listorder.value.val
  //     .fold(0, (prev, element) => int.parse(prev.toString()) + element['qty'] * element['price']);
  // final _totalQty = Val.listorder.value.val.fold(0, (prev, element) => int.parse(prev.toString()) + element['qty']);
  // final GlobalKey globalKey = GlobalKey();
  // final _gambarStruk = <Uint8List>[].obs;
  // String Function() get _change =>
  //     () => (int.parse(_toPay.value.val.toString()) - int.parse(_totalPrice.toString())).toString();
  // final _paymentMethod = {}.obs;

  // _onload() async {
  //   Val.billId.value.val = const ShortUuid().generate();
  //   Val.billId.refresh();

  //   // await LoadData().paymentMethod();
  // }

  @override
  Widget build(BuildContext context) {
    CheckoutVal.onload();
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Material(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(
                        onPressed: () {
                          if (Vl.employeeId.val.isNotEmpty) {
                            Get.toNamed(Pages.empHomePage().route);
                          } else {
                            Get.toNamed(Pages.homePage().route);
                          }
                        },
                      ),
                      Visibility(
                        visible: media.isMobile,
                        child: IconButton(
                            onPressed: () {
                              Get.dialog(
                                SimpleDialog(
                                  children: [
                                    // MaterialButton(
                                    //     child: Text("lihat"),
                                    //     onPressed: () async {
                                    //       final RenderRepaintBoundary boundary =
                                    //           globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
                                    //       final image = await boundary.toImage();

                                    //       final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
                                    //       final Uint8List pngBytes = byteData!.buffer.asUint8List();
                                    //       _gambarStruk.assignAll([pngBytes]);
                                    //       final Im.Image img = Im.Image.fromBytes(50, 50, pngBytes);
                                    //       Get.to(PrinterAndroid(i: img));
                                    //       // debugPrint(pngBytes.toString());
                                    //     }),
                                    Struk(media: media),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.feed_outlined)),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(visible: !media.isMobile, child: Struk(media: media)),
                      Expanded(
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              Flexible(
                                child: ListView(
                                  controller: ScrollController(),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // bill id
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Bill ID: ",
                                                    ),
                                                    Text(
                                                      Val.billId.value.val.toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    const Text("Bill No"),
                                                    const Text(
                                                      "00001",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Divider(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Total Tagihan: "),
                                                    Text(
                                                      NumberFormat.currency(
                                                        locale: 'id_ID',
                                                        symbol: 'Rp',
                                                        decimalDigits: 0,
                                                      ).format(CheckoutVal.totalPrice),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Amount Value: "),
                                                    Obx(
                                                      () => Text(
                                                        NumberFormat.currency(
                                                          locale: 'id_ID',
                                                          symbol: 'Rp',
                                                          decimalDigits: 0,
                                                        ).format(int.parse(CheckoutVal.toPay.value.val)),
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    const Text(
                                                      "Change",
                                                    ),
                                                    Text(
                                                      NumberFormat.currency(
                                                        locale: 'id_ID',
                                                        symbol: 'Rp. ',
                                                        decimalDigits: 0,
                                                      ).format(int.parse(CheckoutVal.change().toString())).contains("-")
                                                          ? "0"
                                                          : NumberFormat.currency(
                                                              locale: 'id_ID',
                                                              symbol: 'Rp. ',
                                                              decimalDigits: 0,
                                                            ).format(int.parse(CheckoutVal.change().toString())),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // Divider(),
                                          // payment method
                                          // Text(
                                          //   "Payment Method: ",
                                          // ),

                                          Builder(
                                            builder: (context) {
                                              final lsPaymentMethod = [].obs;
                                              RouterApi.paymentMethodList().getData().then((value) =>
                                                  value.statusCode == 200
                                                      ? lsPaymentMethod.assignAll(jsonDecode(value.body) as List)
                                                      : debugPrint(value.body));
                                              return Obx(
                                                () => DropdownButtonFormField(
                                                  validator: (value) => (value.toString() == "null")
                                                      ? "payment method is required"
                                                      : null,
                                                  decoration: const InputDecoration(
                                                    hintText: "Select Payment Method",
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                    ),
                                                  ),
                                                  items: [
                                                    for (final cat in lsPaymentMethod)
                                                      DropdownMenuItem(
                                                        value: cat,
                                                        child: Text(cat['name'].toString()),
                                                      ),
                                                  ],
                                                  onChanged: (value) {
                                                    debugPrint(value.toString());
                                                    CheckoutVal.paymentMethod.assignAll(value as Map);
                                                  },
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        children: [
                                          for (final itm in CheckoutVal.listHotKey)
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: MaterialButton(
                                                color: Colors.cyan,
                                                child: Text(
                                                  itm == "uang pas"
                                                      ? "Uang Pas"
                                                      : NumberFormat.currency(
                                                          locale: 'id_ID',
                                                          symbol: '',
                                                          decimalDigits: 0,
                                                        ).format(int.parse(itm)),
                                                  style: const TextStyle(
                                                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  if (itm == "uang pas") {
                                                    CheckoutVal.toPay.value.val = CheckoutVal.totalPrice.toString();
                                                    CheckoutVal.toPay.refresh();
                                                  } else {
                                                    CheckoutVal.toPay.value.val = itm;
                                                    CheckoutVal.toPay.refresh();
                                                  }
                                                },
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: media.isMobile,
                                      child: _calculator(media),
                                    ),
                                  ],
                                ),
                              ),
                              Builder(builder: (context) {
                                final loading = false.obs;
                                return Obx(
                                  () => Column(
                                    children: [
                                      Visibility(
                                        visible: int.parse(CheckoutVal.toPay.value.val) >= CheckoutVal.totalPrice,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: loading.value
                                              ? const Text("loading ...")
                                              : MaterialButton(
                                                  color: Colors.cyan,
                                                  onPressed: () async {
                                                    loading.value = true;
                                                    final bill = <String, String>{
                                                      "id": Val.billId.value.val.toString(),
                                                      "totalQty": CheckoutVal.totalQty.toString(),
                                                      "totalPrice": CheckoutVal.totalPrice.toString(),
                                                      "userId": Vl.userId.val.toString(),
                                                      "companyId": Vl.companyId.val.toString(),
                                                      "outletId": Vl.outletId.val.toString(),
                                                      // "employeeId": "",
                                                      // "cashierId": "",
                                                      // "discount": "",
                                                      // "tax": "",
                                                      "payment": CheckoutVal.toPay.value.val,
                                                      "change": CheckoutVal.change(),
                                                      // "customerId": ""
                                                    };

                                                    final listOrder = [];
                                                    for (final itm in Val.listorder.value.val) {
                                                      final order = {
                                                        "quantity": itm['qty'],
                                                        "note": itm['note'],
                                                        "total": itm['total'],
                                                        // "discount": "",
                                                        // "tax": "",
                                                        "productId ": itm['productId'],
                                                        "billId": Val.billId.value.val.toString(),
                                                      };

                                                      listOrder.add(order);
                                                    }

                                                    final body = <String, String>{
                                                      "bill": jsonEncode(bill),
                                                      "listOrder": jsonEncode(listOrder)
                                                    };

                                                    try {
                                                      final pay = await RouterApi.billCreate().postData(body);
                                                      await SmartDialog.showToast("Payment Success");
                                                      Val.change.value.val = CheckoutVal.change();
                                                      // Val.billId.value.val = Val.billId.value.val;

                                                      // Val.struk.value.val = _struk(media).toString();
                                                      Get.offAllNamed(Pages.paymentSuccessPage().route);
                                                      loading.value = false;
                                                    } catch (e) {
                                                      debugPrint(e.toString());
                                                      SmartDialog.showToast(e.toString());
                                                    }
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(10.0),
                                                    child: Center(
                                                      child: Text(
                                                        "Pay",
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !media.isMobile,
                        child: _calculator(media),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _calculator(SizingInformation media) => SizedBox(
        width: media.isMobile ? Get.width : 360,
        height: media.isMobile ? 360 : Get.height * 0.5,
        child: Obx(() => Card(
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: false,
                    child: Text(
                      CheckoutVal.toPay.value.val.toString(),
                    ),
                  ),
                  Flexible(
                    child: GridButton(
                      borderColor: Colors.transparent,
                      onPressed: (data) {
                        if (data == "del") {
                          final ini = CheckoutVal.toPay.value.val.split("");
                          ini.removeLast();
                          CheckoutVal.toPay.value.val = ini.join();
                          if (CheckoutVal.toPay.value.val == "") {
                            CheckoutVal.toPay.value.val = "0";
                          }
                          CheckoutVal.toPay.refresh();
                        } else if (data == "c") {
                          CheckoutVal.toPay.value.val = "0";
                          CheckoutVal.toPay.refresh();
                        } else if (data == "") {
                        } else {
                          final ini = CheckoutVal.toPay.value.val.split("");
                          if (ini.first == "0") {
                            ini.removeAt(0);
                          }
                          String jadinya = ini.join();
                          jadinya += data;
                          CheckoutVal.toPay.value.val = jadinya;
                          CheckoutVal.toPay.refresh();
                        }
                      },
                      items: [
                        [
                          _pad(text: "7"),
                          _pad(text: "8"),
                          _pad(text: "9"),
                        ],
                        [
                          _pad(text: "4"),
                          _pad(text: "5"),
                          _pad(text: "6"),
                        ],
                        [
                          _pad(text: "1"),
                          _pad(text: "2"),
                          _pad(text: "3"),
                        ],
                        [
                          _pad(text: "0"),
                          _pad(
                            text: "del",
                            child: const Icon(
                              Icons.backspace,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          _pad(text: "c"),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );

  GridButtonItem _pad({String? text, Widget? child}) => GridButtonItem(
      title: text,
      child: child,
      color: Colors.cyan,
      shape: const BorderSide(color: Colors.white, width: 2),
      textStyle: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold));
}

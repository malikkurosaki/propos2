import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/utils/notif.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

// class _ProductPrimary {
//   final conName = TextEditingController();
//   final conPrice = TextEditingController();
// }

// class _ProductStock {
//   final isInclude = false.obs;
//   TextEditingController stock = TextEditingController(text: "1");
//   TextEditingController minStock = TextEditingController(text: "0");
// }

class ProductCreateSubmit extends StatelessWidget {
  const ProductCreateSubmit({Key? key}) : super(key: key);

  // ProductCreateSubmit({Key? key,
  // required this.media,
  // required this.isLoadingCreateButton
  // }) : super(key: key);
  // final SizingInformation media;
  // final RxBool isLoadingCreateButton;

  // final _ProductPrimary _primary = _ProductPrimary();
  // final _dataStock = _ProductStock();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductVal.isLoadingCreateButton.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    ProductVal.isLoadingCreateButton.value = true;
                    Future.delayed(const Duration(seconds: 2), () => ProductVal.isLoadingCreateButton.value = false);

                    if (ProductVal.primary.conPrice.text.isEmpty || ProductVal.primary.conName.text.isEmpty) {
                      SmartDialog.showToast("nama dan harga tidak diijinkan kosong");
                      return;
                    }

                    final body = <String, dynamic>{
                      "name": ProductVal.primary.conName.text,
                      "price": int.parse(ProductVal.primary.conPrice.text),
                    };

                    if (ProductVal.isCustomPrice.value) {
                      final listCustomePrice = ProductVal.dataCustomPrice.values
                          .where((element) => (element['con'] as TextEditingController).text.isNotEmpty)
                          .map((e) =>
                              {"customPriceId": e['id'], "price": int.parse((e['con'] as TextEditingController).text)})
                          .toList();

                      if (listCustomePrice.isEmpty) {
                        Notif.error(message: "custom price kosong");
                        return;
                      }
                      body['listCustomPrice'] = listCustomePrice;
                    }

                    if (ProductVal.dataImage.isInclude.value) {
                      if (ProductVal.dataImage.imageId.value.isEmpty || ProductVal.dataImage.imageName.isEmpty) {
                        Notif.error(message: "gambar kosong");
                        return;
                      }

                      if (ProductVal.dataImage.imageId.value.isNotEmpty) {
                        body['productImageId'] = ProductVal.dataImage.imageId.value;
                      }
                      if (ProductVal.dataImage.imageName.isNotEmpty) {
                        body['productImageName'] = ProductVal.dataImage.imageName;
                      }
                    }

                    // if (_dataStock.isInclude.value) {
                    //   body['stock'] = _dataStock.stock.text;
                    //   body['nin_stock'] = _dataStock.minStock.text;
                    // }

                    if (ProductVal.dataStock.stock.text.isNotEmpty) {
                      body['stock'] = int.parse(ProductVal.dataStock.stock.text);
                    }
                    if (ProductVal.dataStock.minStock.text.isNotEmpty) {
                      body['ninStock'] = int.parse(ProductVal.dataStock.minStock.text);
                    }

                    if (ProductVal.dataDetail.isInclude.value) {
                      if (ProductVal.dataDetail.companyId.value.isNotEmpty) {
                        body['companyId'] = ProductVal.dataDetail.companyId.value;
                      }
                      if (ProductVal.dataDetail.listoutlet.isNotEmpty) {
                        body['listOutlet'] = ProductVal.dataDetail.listoutlet;
                      }
                      if (ProductVal.dataDetail.des.text.isNotEmpty) body['des'] = ProductVal.dataDetail.des.text;
                      
                      if (ProductVal.dataDetail.modal.text.isNotEmpty) {
                        body['modal'] = int.parse(ProductVal.dataDetail.modal.text);
                      }
                      if (ProductVal.dataDetail.barcodeId.text.isNotEmpty) {
                        body['barcodeId'] = ProductVal.dataDetail.barcodeId.text;
                      }
                      if (ProductVal.dataDetail.sku.text.isNotEmpty) body['sku'] = ProductVal.dataDetail.sku.text;
                      if (ProductVal.dataDetail.berat.text.isNotEmpty) {
                        body['berat'] = int.parse(ProductVal.dataDetail.berat.text);
                      }
                      if (ProductVal.dataDetail.categoryId.value.isNotEmpty) {
                        body['categoryId'] = ProductVal.dataDetail.categoryId.value;
                      }
                      if (ProductVal.dataDetail.dimensi.text.isNotEmpty) {
                        final dimensi = ProductVal.dataDetail.dimensi.text.split(",");
                        try {
                          int.parse(dimensi[0]);
                          int.parse(dimensi[1]);
                          int.parse(dimensi[2]);
                          body['dimensi'] = ProductVal.dataDetail.dimensi.text;
                        } catch (e) {
                          Notif.error(message: "format dimensi salah");
                        }
                      }
                    } else {
                      body['companyId'] = Vl.companyId.val;
                      body['listOutlet'] = [
                        {
                          "outletId": Vl.outletId.val,
                          "companyId": Vl.companyId.val,
                          "userId": Vl.userId.val,
                        }
                      ];
                      body['userId'] = Vl.userId.val;
                    }

                    body['isImage'] = ProductVal.dataImage.isInclude.value;
                    body['isStock'] = ProductVal.dataStock.isInclude.value;
                    body['isDetail'] = ProductVal.dataDetail.isInclude.value;
                    body['isCustomPrice'] = ProductVal.isCustomPrice.value;

                    // print(JsonEncoder.withIndent("   ").convert(body));

                    final kirim = await RouterApi.productCreate().postData({"data": jsonEncode(body)});
                    if (kirim.statusCode == 201) {
                      await ProductVal.onLoad();

                      if (media.isMobile) {
                        Get.back();
                      }
                      SmartDialog.showToast("success");
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
        ),
      );
    });
  }
}

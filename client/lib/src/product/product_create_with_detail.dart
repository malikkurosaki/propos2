import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
import 'package:propos/components/company_select.dart';
import 'package:propos/components/input.dart';
import 'package:propos/components/outlet_multi_select_by_company.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/vl.dart';

// class _ProductDetail {
//   final isInclude = false.obs;
//   final companyId = "".obs;
//   final categoryId = "".obs;
//   final listoutlet = [].obs;
//   final des = TextEditingController();
//   final modal = TextEditingController();
//   final sku = TextEditingController();
//   final barcodeId = TextEditingController();
//   final berat = TextEditingController();
//   final dimensi = TextEditingController();
// }

class ProductCreateWithDetail extends StatelessWidget {
  const ProductCreateWithDetail({Key? key}) : super(key: key);

  // ProductCreateWithDetail({Key? key, required this.lsCategory}) : super(key: key);

  // final dataDetail = _ProductDetail();
  // final RxList<dynamic> lsCategory;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(ProductVal.dataDetail.isInclude.value ? 8 : 0),
        margin: EdgeInsets.all(ProductVal.dataDetail.isInclude.value ? 16 : 0),
        decoration: BoxDecoration(border: !ProductVal.dataDetail.isInclude.value ? null : Border.all()),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Include Detail"),
                    Checkbox(
                      value: ProductVal.dataDetail.isInclude.value,
                      onChanged: (value) {
                        ProductVal.dataDetail.isInclude.value = value!;
                      },
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "jika tidak menggunakan detail akan menggunakan default detail pada saat ini yang tersedia",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            Visibility(
              visible: ProductVal.dataDetail.isInclude.value,
              child: Column(
                children: [
                  CompanySelect(
                    onSelectCompany: (companyId) async {
                      final ctgr = await RouterApi.categoryByCompanyId(query: "cusCompanyId=$companyId").getData();
                      ProductVal.lsCategory.assignAll(jsonDecode(ctgr.body));
                      ProductVal.dataDetail.companyId.value = companyId;
                    },
                  ),
                  Column(
                    children: [
                      Visibility(visible: false, child: Text(ProductVal.lsCategory.toString())),
                      FutureBuilder<RxList>(
                        future: (() async => ProductVal.lsCategory)(),
                        builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
                            ? _temSelect("Select Category")
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      labelStyle: TextStyle(backgroundColor: Colors.white),
                                      labelText: "Select Category",
                                      isDense: true,
                                      border: OutlineInputBorder(borderSide: BorderSide.none),
                                      filled: true),
                                  items: [
                                    ...ProductVal.lsCategory.map(
                                      (element) => DropdownMenuItem(
                                        value: element,
                                        child: Text(element['name'].toString()),
                                      ),
                                    )
                                  ],
                                  onChanged: (value) {
                                    ProductVal.dataDetail.categoryId.value = (value as Map)['id'];
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                  OutletMultiSelectByCompany(
                    companyId: ProductVal.dataDetail.companyId.value,
                    onSelectOutlet: (value) {
                      // debugPrint(value.toString());
                      // _selectedoutletList.assignAll(value);
                      final hasil = value.map(
                        (e) => {
                          "outletId": e,
                          "companyId": ProductVal.dataDetail.companyId.value,
                          "userId": Vl.userId.val,
                        },
                      );
                      ProductVal.dataDetail.listoutlet.assignAll(hasil);
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     textInputAction: TextInputAction.next,
                  //     keyboardType: TextInputType.number,
                  //     controller: _detail.des,
                  //     decoration: const InputDecoration(
                  //       labelText: "Product Description",
                  //       labelStyle: TextStyle(backgroundColor: Colors.white),
                  //       filled: true,
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Input(
                    controller: ProductVal.dataDetail.des,
                    hint: "keterangan",
                  ),
                  Input(
                    onChanged: (value) {
                      if (int.tryParse(value) == null) ProductVal.dataDetail.modal.clear();
                    },
                    controller: ProductVal.dataDetail.modal,
                    hint: "Harga Modal",
                  ),
                  Input(
                    controller: ProductVal.dataDetail.sku,
                    hint: "SKU",
                  ),
                  Input(
                    controller: ProductVal.dataDetail.barcodeId,
                    hint: "Barcode Id",
                  ),
                  Input(
                    controller: ProductVal.dataDetail.berat,
                    hint: "Berat",
                    onChanged: (value) {
                      if (int.tryParse(value) == null) ProductVal.dataDetail.berat.clear();
                    },
                  ),
                  Input(
                    controller: ProductVal.dataDetail.dimensi,
                    hint: "Dimensi",
                    info: "P x L x T, contoh 120, 120, 10",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _temSelect(String lable) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
              labelText: lable,
              labelStyle: const TextStyle(backgroundColor: Colors.white),
              filled: true,
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      );
}

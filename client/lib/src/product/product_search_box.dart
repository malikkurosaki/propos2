import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
import 'package:propos/components/outlet_multi_select_by_company.dart';
import 'package:propos/components/search_view_with_checkbox.dart';
import 'package:get/get.dart';
import 'package:propos/src/product/product_val.dart';


// class ProductSearchBox extends StatelessWidget {
//   const ProductSearchBox({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SearchViewWithCheckbox(
//       onChanged: (searchValue) {},
//       checkValue: ProductVal.isCheckAll,
//       onCheckChanged: (checkValue) {
//         if (checkValue!) {
//           ProductVal.listSelected.assignAll(ProductVal.lsProduct.map((e) => e['id']));
//           ProductVal.isShowChecked.value = true;
//         } else {
//           ProductVal.listSelected.clear();
//           ProductVal.isShowChecked.value = false;
//         }
//         ProductVal.isCheckAll.value = checkValue;
//       },
//       subtitle: Obx(() => Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                   tooltip: "Hapus Sekaligus",
//                   onPressed: ProductVal.listSelected.isEmpty
//                       ? null
//                       : () {
//                           Get.dialog(
//                             AlertDialog(
//                               title: const Text("Dihapus Sekaligus"),
//                               content: Text("Yakin Mau Menghapus ${ProductVal.listSelected.length} Product Yang Dipilih ?"),
//                               actions: [
//                                 MaterialButton(
//                                     child: const Text("Tidak"),
//                                     onPressed: () {
//                                       Get.back();
//                                     }),
//                                 MaterialButton(
//                                     child: const Text("Ya"),
//                                     onPressed: () {
//                                       Get.back();
//                                     })
//                               ],
//                             ),
//                           );
//                         },
//                   icon: Icon(
//                     Icons.delete_sweep,
//                     color: ProductVal.listSelected.isEmpty ? Colors.grey : Colors.pink,
//                   )),
//               IconButton(
//                 onPressed: ProductVal.listSelected.isEmpty
//                     ? null
//                     : () {
//                         showBottomSheet(
//                           backgroundColor: Colors.transparent,
//                           context: context,
//                           builder: (c) => Card(
//                             margin: const EdgeInsets.all(16),
//                             elevation: 5,
//                             child: SizedBox(
//                               height: 500,
//                               width: double.infinity,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [const BackButton()],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text("Company : ${ProductVal.company['name']}"),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text("Product : ${ProductVal.listSelected.length} Selected"),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: OutletMultiSelectByCompany(
//                                       companyId: ProductVal.company['id'],
//                                       onSelectOutlet: (value) {},
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                 icon: Icon(
//                   Icons.move_down,
//                   color: ProductVal.listSelected.isEmpty ? Colors.grey : Colors.orange,
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }

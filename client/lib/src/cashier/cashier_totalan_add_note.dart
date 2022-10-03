import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/src/cashier/cashier_select_discount.dart';
import 'package:propos/utils/val.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CashierTotalanAddNote extends StatelessWidget {
  CashierTotalanAddNote({Key? key, required this.itm}) : super(key: key);
  final Map itm;
  final _conName = TextEditingController();

  _onLoad() {
    _conName.text = itm['note'].toString();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Material(
      color: Colors.grey.shade100,
      // title: Text("Note"),
      child: Column(
        children: [
          Container(
            color: Colors.orange,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                BackButton(
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    itm['name'].toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    final data = List.from(Val.listorder.value.val);
                    final idx = data.indexWhere((element) => element['id'] == itm['id']);
                    data[idx]['note'] = _conName.text;
                    Val.listorder.value.val = data;
                    Val.listorder.refresh();
                    SmartDialog.showToast("Note Saved");
                    Get.back();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.orange),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Add Note",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: TextField(
              controller: _conName,
              decoration: InputDecoration(
                hintText: 'Note',
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                _conName.clear();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.orange,
              ),
            ),
          ),
          // ListTile(
          //   title: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       MaterialButton(
          //         child: Text("Cancel"),
          //         onPressed: () {
          //           Get.back();
          //         },
          //       ),
          //       MaterialButton(
          //         child: Text("Ok"),
          //         onPressed: () {

          //         },
          //       ),
          //     ],
          //   ),
          // ),
          Divider(),
          ListTile(
            title: Text(
              "Add Discount",
              style: TextStyle(fontSize: 18),
            ),
          ),
          CashierSelectDiscount(
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}

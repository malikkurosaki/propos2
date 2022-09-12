import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/router_api.dart';

class CashierSearchBox extends StatelessWidget {
  const CashierSearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextField(
            onChanged: (value) async {
              final data = await RouterApi.productSearch(query: "search=$value").getData();
              if (data.statusCode == 200) {
                final dataSearch = jsonDecode(data.body);
                CashierVal.listProduct.value.val = dataSearch;
                CashierVal.listProduct.refresh();
              }
              ;
            },
            controller: CashierVal.conSearch,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      );
  }
}
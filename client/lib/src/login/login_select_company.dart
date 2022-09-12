import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:propos/src/login/login_val.dart';

class LoginSelectCompany extends StatelessWidget {
  const LoginSelectCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField(
        items: LoginVal.listCompany
            .map((element) => DropdownMenuItem(value: element, child: Text(element['name'])))
            .toList(),
        onChanged: (value) {
          debugPrint((value as Map).toString());
        },
      ),
    );
  }
}

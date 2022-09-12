import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/src/login/login_select_company.dart';

class LoginDialogSelect extends StatelessWidget {
  const LoginDialogSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          LoginSelectCompany()
        ],
      ),
    );
  }
}

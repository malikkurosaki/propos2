import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({Key? key, this.text, this.label, this.hint, this.onChanged, this.info, this.controller})
      : super(key: key);

  /// ## Type : String?
  /// mengisi keterangan saat muncul
  /// dan akan pindah keatasnya saat box input berisi value
  final String? label;

  /// ## final String? label
  /// > akan menghilang saat vaue terisi
  final String? hint;

  /// ## final String? text
  /// nilai defautl saat pertama load
  final String? text;

  /// ## final Function(String)? onChanged;
  /// ```js
  /// // mendapatkan nilai ketika ada perubahan pada box input
  /// ```
  final Function(String)? onChanged;

  /// ## final String? info;
  /// ```js
  /// // optional menambahkan info pada bawah kiri box
  /// -------------------
  /// |  input box      |
  /// -------------------
  ///               info
  /// ```
  final String? info;

  /// final TextEditingController? controller;
  /// ```js
  /// // memungkinkan untuk menambahkan controller
  /// ```
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: 
      Column(
        children: [
          TextField(
            onEditingComplete: () {
              debugPrint("next");
            },
            textInputAction: TextInputAction.next,
            controller: controller ?? TextEditingController(text: text),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              filled: true,
              isDense: true,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              info ?? "",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

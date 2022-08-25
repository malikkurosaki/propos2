import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key, required this.onChanged, this.controller}) : super(key: key);
  final Function(String value) onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
                onPressed: controller == null? null: () {
                  controller!.clear();
                },
                icon: Icon(Icons.close)),
            hintText: 'Search',
            filled: true,
            isDense: true,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:propos/components/search_view.dart';

class SearchViewWithCheckbox extends StatelessWidget {
  const SearchViewWithCheckbox(
      {Key? key, required this.onChanged, required this.checkValue, required this.onCheckChanged, this.subtitle})
      : super(key: key);

  final Function(String searchValue) onChanged;
  final RxBool checkValue;
  final ValueChanged<bool?> onCheckChanged;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Obx(
        () => Tooltip(
          message: "Select All",
          child: Checkbox(
            value: checkValue.value,
            onChanged: onCheckChanged,
          ),
        ),
      ),
      title: SearchView(
        onChanged: onChanged,
      ),
      subtitle: subtitle,
    );
  }
}

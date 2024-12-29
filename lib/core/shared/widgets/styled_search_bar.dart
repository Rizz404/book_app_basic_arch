import 'package:flutter/material.dart';

class StyledSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onIconPressed;
  final void Function(String) onChanged;
  final String? hintText;

  const StyledSearchBar({
    super.key,
    required this.controller,
    required this.onIconPressed,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: WidgetStateProperty.all(0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      controller: controller,
      hintText: hintText,
      leading: const Icon(Icons.search),
      trailing: [
        if (controller.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          ),
      ],
      onChanged: onChanged,
    );
  }
}

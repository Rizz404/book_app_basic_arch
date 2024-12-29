import 'package:flutter/material.dart';

class StyledSearchBarPlaceholder extends StatelessWidget {
  final void Function()? onTap;
  final String? hintText;

  const StyledSearchBarPlaceholder({
    super.key,
    this.onTap,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: SearchBar(
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          hintText: hintText,
          leading: const Icon(Icons.search),
        ),
      ),
    );
  }
}

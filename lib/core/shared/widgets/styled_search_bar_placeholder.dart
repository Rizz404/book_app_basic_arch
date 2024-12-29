import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StyledSearchBarPlaceholder extends StatelessWidget {
  final String? hintText;

  const StyledSearchBarPlaceholder({
    super.key,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/search'),
      child: AbsorbPointer(
        absorbing: true,
        child: SearchBar(
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          hintText: hintText ?? "Cari buku, genre, author, atau publisher",
          leading: const Icon(Icons.search),
        ),
      ),
    );
  }
}

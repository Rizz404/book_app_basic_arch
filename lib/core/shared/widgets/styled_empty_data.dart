import 'package:flutter/material.dart';

class StyledEmptyData extends StatelessWidget {
  final String message;

  const StyledEmptyData({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}

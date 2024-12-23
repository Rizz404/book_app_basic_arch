import 'package:flutter/material.dart';

class StyledLoadingState extends StatelessWidget {
  const StyledLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

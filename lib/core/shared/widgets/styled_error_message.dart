import 'package:flutter/material.dart';

class StyledErrorMessage extends StatelessWidget {
  final String errorMessage;
  final void Function()? onRetry;

  const StyledErrorMessage({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Error: $errorMessage",
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: const Text("Retry"),
            ),
        ],
      ),
    );
  }
}

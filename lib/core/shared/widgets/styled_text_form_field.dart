import 'package:flutter/material.dart';

class StyledTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? label;
  final TextInputType keyboardType;
  final bool isPassword;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final int? maxLines;
  final EdgeInsets contentPadding;
  final OutlineInputBorder? border;
  final Color? fillColor;
  final bool filled;
  final String? Function(String?)? validator;
  final bool readOnly; // Tambah parameter readOnly
  final VoidCallback? onTap; // Tambah parameter onTap

  const StyledTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.leadingIcon,
    this.trailingIcon,
    this.maxLines = 1,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.border,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.readOnly = false, // Tambahkan di constructor
    this.onTap, // Tambahkan di constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      maxLines: maxLines,
      validator: validator,
      readOnly: readOnly, // Tambahkan property readOnly
      onTap: onTap, // Tambahkan property onTap
      decoration: InputDecoration(
        label: label,
        hintText: hintText,
        prefixIcon: leadingIcon,
        suffixIcon: trailingIcon, // Gunakan suffixIcon jika ada
        contentPadding: contentPadding,
        filled: filled,
        fillColor:
            fillColor ?? Theme.of(context).colorScheme.surfaceContainerHighest,
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
        enabledBorder: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
        focusedBorder: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
      ),
    );
  }
}

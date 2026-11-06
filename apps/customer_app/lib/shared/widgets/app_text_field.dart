import 'package:customer_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A labelled, brand-styled form field used across the auth flow.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.helperText,
    this.prefixIcon,
    this.focusNode,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.validator,
    this.autofillHints,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.enabled = true,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;

  /// Persistent guidance shown under the field, such as password rules.
  final String? helperText;

  final IconData? prefixIcon;

  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final void Function(String)? onFieldSubmitted;

  /// Masks input and adds a show/hide toggle.
  final bool obscureText;

  /// Set false while a request is in flight to lock the field.
  final bool enabled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          autofillHints: widget.autofillHints,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: _obscured,
          enabled: widget.enabled,
          autocorrect: !widget.obscureText,
          enableSuggestions: !widget.obscureText,
          style: const TextStyle(fontSize: 15.5, color: AppColors.ink),
          decoration: InputDecoration(
            hintText: widget.hint,
            helperText: widget.helperText,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon, size: 20, color: AppColors.inkMuted),
            suffixIcon: _buildVisibilityToggle(),
          ),
        ),
      ],
    );
  }

  Widget? _buildVisibilityToggle() {
    if (!widget.obscureText) return null;
    return IconButton(
      onPressed: () => setState(() => _obscured = !_obscured),
      icon: Icon(
        _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        size: 20,
      ),
      color: AppColors.inkMuted,
      tooltip: _obscured ? 'Show password' : 'Hide password',
    );
  }
}

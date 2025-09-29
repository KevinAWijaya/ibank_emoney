import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';

class VTextField extends StatefulWidget {
  const VTextField({super.key, required this.hint, required this.controller, this.isObscure = false});

  final String hint;
  final TextEditingController controller;
  final bool isObscure;

  @override
  State<VTextField> createState() => _VTextFieldState();
}

class _VTextFieldState extends State<VTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
    widget.controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFilled = widget.controller.text.isNotEmpty;

    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: textBody3.copyWith(color: VColor.neutral1),
      decoration: InputDecoration(
        hint: Text(widget.hint, style: textBody3.copyWith(color: VColor.neutral4)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: VColor.neutral4, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: VColor.neutral4, width: 1.0),
        ),
        suffixIcon: widget.isObscure
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: isFilled ? VColor.neutral1 : VColor.neutral4,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

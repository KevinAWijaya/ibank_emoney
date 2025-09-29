import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';

class VTextField extends StatefulWidget {
  const VTextField({super.key, required this.hint, this.suffixIcon});
  final String hint;
  final IconData? suffixIcon;

  @override
  State<VTextField> createState() => _VTextFieldState();
}

class _VTextFieldState extends State<VTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFilled = _controller.text.isNotEmpty;

    return TextField(
      controller: _controller,
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
        suffixIcon: widget.suffixIcon == null
            ? SizedBox.shrink()
            : Icon(widget.suffixIcon, color: isFilled ? VColor.neutral1 : VColor.neutral4),
      ),
    );
  }
}

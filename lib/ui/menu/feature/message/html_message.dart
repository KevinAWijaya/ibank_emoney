import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank_emoney/core/theme/color.dart';

class HtmlMessage extends StatelessWidget {
  final String htmlText;

  const HtmlMessage({super.key, required this.htmlText});

  @override
  Widget build(BuildContext context) {
    final textBody3 = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500);

    return Html(
      data: htmlText,
      style: {
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontFamily: textBody3.fontFamily,
          fontSize: FontSize(textBody3.fontSize!),
          fontWeight: textBody3.fontWeight,
          color: Colors.black, // default color
        ),
        "b": Style(
          fontFamily: textBody3.fontFamily,
          fontSize: FontSize(textBody3.fontSize!),
          fontWeight: FontWeight.w700, // make b bolder
          color: VColor.primary1, // override <b> style
        ),
        "span": Style(
          fontFamily: textBody3.fontFamily,
          fontSize: FontSize(textBody3.fontSize!),
          fontWeight: textBody3.fontWeight,
        ),
      },
    );
  }
}

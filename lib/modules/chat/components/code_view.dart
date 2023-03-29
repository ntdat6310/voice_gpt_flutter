import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class CodeViewWidget extends StatelessWidget {
  const CodeViewWidget({Key? key, required this.code}) : super(key: key);
  final String code;

  @override
  Widget build(BuildContext context) {
    return SyntaxView(
      code: code,
      syntax: Syntax.DART, // Language
      syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
      fontSize: 12.0, // Font size
      withZoom: false, // Enable/Disable zoom icon controls
      withLinesCount: false, // Enable/Disable line number
      expanded: false, // Enable/Disable container expansion
    );
  }
}

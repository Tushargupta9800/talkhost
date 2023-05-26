import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; 
import '/custom_code/actions/index.dart'; 
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownRenderer extends StatefulWidget {
  const MarkdownRenderer({
    Key? key,
    this.width,
    this.height,
    required this.data,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String data;

  @override
  _MarkdownRendererState createState() => _MarkdownRendererState();
}

class _MarkdownRendererState extends State<MarkdownRenderer> {
  @override
  Widget build(BuildContext context) {
    return Markdown(
      selectable: true,
      data: widget.data,
      styleSheet: MarkdownStyleSheet.fromTheme(
        Theme.of(
          context,
        ),
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the button on the right!
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MarkupDomain {
  //...Fields
  final TextStyle? textStyle;
  final GestureRecognizer? recognizer;
  final String Function(String source)? transform;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final MouseCursor? mouseCursor;
  final String? semanticsLabel;

  MarkupDomain({
    this.textStyle,
    this.recognizer,
    this.transform,
    this.onEnter,
    this.onExit,
    this.mouseCursor,
    this.semanticsLabel,
  });
}

library selectable_text2;

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:text2/text2.dart';

/// ## Selectable Text 2.0
/// Advanced selectable text widget with markups
/// and modifiers. Provides most features already
/// found in [SelectableText] but with extra spice
/// of markup implementation.
///
/// See: [Markup], [MarkupTheme] and [Text2]
///
/// ```dart
/// SelectableText2(
///   '[bold](It's) the [italic](dawn) of time',
/// );
/// ```
class SelectableText2 extends StatelessWidget {
  //...Fields
  final String data;
  final Markup? markup;
  final Locale? locale;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? semanticsLabel;
  final bool? softWrap;
  final StrutStyle? strutStyle;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;
  final TextWidthBasis? textWidthBasis;
  final bool autofocus;
  final Color? cursorColor;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final double cursorWidth;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final FocusNode? focusNode;
  final int? minLines;
  final SelectionCallback? onSelectionChanged;
  final VoidCallback? onTap;
  final ScrollPhysics? scrollPhysics;
  final TextSelectionControls? selectionControls;
  final bool showCursor;
  final bool benchmarkSpeed;
  final ContextMenuBuilder? contextMenuBuilder;

  const SelectableText2(
    this.data, {
    super.key,
    this.markup,
    this.locale,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    this.softWrap,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    this.textScaleFactor,
    this.textWidthBasis,
    this.autofocus = false,
    this.cursorColor,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorWidth = 2.0,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.focusNode,
    this.minLines,
    this.onSelectionChanged,
    this.onTap,
    this.scrollPhysics,
    this.selectionControls,
    this.showCursor = false,
    this.benchmarkSpeed = false,
    this.contextMenuBuilder,
  });

  @override
  Widget build(BuildContext context) {
    //...
    int? start;
    final theme = Theme.of(context).text2Theme;
    final defaultStyle = DefaultTextStyle.of(context).style;
    final style = this.style ?? theme.style ?? defaultStyle;
    final markup = this.markup ?? theme.markup ?? const Markup('');
    if (benchmarkSpeed) start = DateTime.now().millisecondsSinceEpoch;
    final applier = MarkupParser(data, style: style).clean().parse();
    final spans = applier.toTextSpans(context, markup: markup);
    if (benchmarkSpeed) {
      final end = DateTime.now().millisecondsSinceEpoch;
      log("Text 2.0 Took ${end - start!} milliSec to process.");
    }
    return SelectableText.rich(
      spans,
      style: style,
      maxLines: maxLines ?? theme.maxLines,
      strutStyle: strutStyle ?? theme.strutStyle,
      textAlign: textAlign ?? theme.textAlign,
      textDirection: textDirection ?? theme.textDirection,
      textHeightBehavior: textHeightBehavior ?? theme.textHeightBehavior,
      textScaleFactor: textScaleFactor ?? theme.textScaleFactor,
      textWidthBasis: textWidthBasis ?? theme.textWidthBasis,
      autofocus: autofocus,
      cursorColor: cursorColor,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorWidth: cursorWidth,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      focusNode: focusNode,
      minLines: minLines,
      onSelectionChanged: onSelectionChanged,
      onTap: onTap,
      scrollPhysics: scrollPhysics,
      selectionControls: selectionControls,
      showCursor: showCursor,
      contextMenuBuilder: contextMenuBuilder,
    );
  }
}

typedef ContextMenuBuilder = Widget Function(
  BuildContext context,
  EditableTextState state,
);

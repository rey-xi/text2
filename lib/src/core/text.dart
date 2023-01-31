library text2;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:text2/text2.dart';

class Text2 extends StatelessWidget {
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
  final bool benchmarkSpeed;

  const Text2(
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
    this.benchmarkSpeed = false,
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
    final applier = MultiStyleParser(data, style: style).clean().parse();
    final spans = applier.toTextSpans(context, extraMarkup: markup);
    if (benchmarkSpeed) {
      final end = DateTime.now().millisecondsSinceEpoch;
      log("Text 2.0 Took ${end - start!} milliSec to process.");
    }

    return Text.rich(
      spans,
      style: style,
      locale: locale ?? theme.locale,
      maxLines: maxLines ?? theme.maxLines,
      overflow: overflow ?? theme.overflow,
      semanticsLabel: semanticsLabel ?? theme.semanticsLabel,
      softWrap: softWrap ?? theme.softWrap,
      strutStyle: strutStyle ?? theme.strutStyle,
      textAlign: textAlign ?? theme.textAlign,
      textDirection: textDirection ?? theme.textDirection,
      textHeightBehavior: textHeightBehavior ?? theme.textHeightBehavior,
      textScaleFactor: textScaleFactor ?? theme.textScaleFactor,
      textWidthBasis: textWidthBasis ?? theme.textWidthBasis,
    );
  }
}

typedef SelectionCallback = void Function(
  TextSelection,
  SelectionChangedCause?,
);

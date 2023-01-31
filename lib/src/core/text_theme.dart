import 'dart:ui';

import 'package:flutter/material.dart';

import '../markup/markup.dart';

class Text2Theme extends StatelessWidget
    implements //
        ThemeExtension<Text2Theme> {
  //...Fields
  final Markup? markup;
  final Locale? locale;
  final int? maxLines;
  final bool? softWrap;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;
  final double? textScaleFactor;
  final String? semanticsLabel;
  final Widget? child;

  const Text2Theme({
    super.key,
    this.markup,
    this.locale,
    this.maxLines,
    this.softWrap,
    this.style,
    this.textAlign,
    this.overflow,
    this.strutStyle,
    this.textDirection,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.textScaleFactor,
    this.semanticsLabel,
    this.child,
  });

  //...Getters
  @override
  Object get type => Text2Theme;

  //...Methods
  @override
  Text2Theme copyWith({
    Markup? markup,
    Locale? locale,
    int? maxLines,
    TextOverflow? overflow,
    String? semanticsLabel,
    bool? softWrap,
    StrutStyle? strutStyle,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) {
    //...
    return Text2Theme(
      markup: markup ?? this.markup,
      locale: locale ?? this.locale,
      maxLines: maxLines ?? this.maxLines,
      overflow: overflow ?? this.overflow,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      softWrap: softWrap ?? this.softWrap,
      strutStyle: strutStyle ?? this.strutStyle,
      style: style ?? this.style,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
    );
  }

  Text2Theme copy(Text2Theme? other) {
    //...
    return Text2Theme(
      markup: other?.markup ?? markup,
      locale: other?.locale ?? locale,
      maxLines: other?.maxLines ?? maxLines,
      overflow: other?.overflow ?? overflow,
      semanticsLabel: other?.semanticsLabel ?? semanticsLabel,
      softWrap: other?.softWrap ?? softWrap,
      strutStyle: other?.strutStyle ?? strutStyle,
      style: other?.style ?? style,
      textAlign: other?.textAlign ?? textAlign,
      textDirection: other?.textDirection ?? textDirection,
      textHeightBehavior: other?.textHeightBehavior ?? textHeightBehavior,
      textScaleFactor: other?.textScaleFactor ?? textScaleFactor,
      textWidthBasis: other?.textWidthBasis ?? textWidthBasis,
    );
  }

  @override
  Text2Theme lerp(other, double t) {
    //...
    if (other is! Text2Theme) return this;
    return Text2Theme(
      markup: other.markup ?? markup,
      locale: other.locale ?? locale,
      maxLines: other.maxLines ?? maxLines,
      overflow: other.overflow ?? overflow,
      semanticsLabel: other.semanticsLabel ?? semanticsLabel,
      softWrap: other.softWrap ?? softWrap,
      strutStyle: other.strutStyle ?? strutStyle,
      style: TextStyle.lerp(style, other.style, t),
      textAlign: other.textAlign ?? textAlign,
      textDirection: other.textDirection ?? textDirection,
      textHeightBehavior: other.textHeightBehavior ?? textHeightBehavior,
      textScaleFactor: lerpDouble(textScaleFactor, other.textScaleFactor, t),
      textWidthBasis: other.textWidthBasis ?? textWidthBasis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(extensions: {
        ...Theme.of(context).extensions.values,
        this,
      }),
      child: child ?? const SizedBox(),
    );
  }
}

extension Text2ThemeData on ThemeData {
  //...Getters
  Text2Theme get text2Theme {
    return const Text2Theme().copy(extension<Text2Theme>());
  }
}

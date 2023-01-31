import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'markup.dart';
import 'markup_domain.dart';
import 'markup_theme.dart';
import 'markup_token.dart';

class MarkupApplier {
  //...Fields
  int start, end;
  final String sample;
  final List<MarkupToken> tokens;
  final List<MarkupApplier> children;
  final TextStyle? style;

  MarkupApplier(
    this.tokens,
    this.sample,
    this.start,
    this.end, {
    this.children = const [],
    required this.style,
  });

  //...Getters
  List get props => [tokens, start, end, sample, children];

  //...Methods
  @override
  String toString() => mapPropsToString(runtimeType, props);

  String mapPropsToString(Type type, List<Object?> props) {
    //...
    final args = props.map((prop) => prop.toString());
    return '$type(${args.join(', ')})';
  }

  MarkupDomain? _mergedStyles(Iterable<Markup>? stylingSheet) {
    //...
    if (stylingSheet == null) return null;

    final sheet = <String, Markup>{
      for (var style in stylingSheet) ...style.spread,
    };

    TextStyle rStyle = const TextStyle();

    GestureRecognizer? winnerGesture;
    MouseCursor? winnerCursor;
    String? semmanticLabel;

    final allOnEnter = <void Function(PointerEnterEvent)?>[];
    final allOnExit = <void Function(PointerExitEvent)?>[];
    final transformers = <String Function(String source)?>[];

    for (var style in tokens) {
      final sts = sheet[style.code];

      if (sts?.styling != null) {
        rStyle = rStyle.merge(sts?.styling!(style.modifier));
      }

      if (sts?.refactoring != null) {
        final qStyle = this.style?.merge(rStyle) ?? rStyle;
        rStyle = rStyle.merge(sts?.refactoring!(qStyle, style.modifier));
      }

      if (sts?.transformation != null) {
        transformers.add((_) => sts!.transformation!(_, style.modifier));
      }

      if (sts?.recognition != null) {
        winnerGesture = sts?.recognition!(style.modifier);
      }
      winnerCursor ??= sts?.mouseCursor;

      if (sts?.onEnter != null) {
        allOnEnter.add(sts?.onEnter);
      }
      if (sts?.onExit != null) {
        allOnExit.add(sts?.onExit);
      }

      if (sts?.semanticsLabel != null) {
        semmanticLabel = "${semmanticLabel ?? ""} ${sts!.semanticsLabel}";
      }
    }

    return MarkupDomain(
      textStyle: rStyle,
      recognizer: winnerGesture,
      mouseCursor: winnerCursor,
      // ignore: avoid_function_literals_in_foreach_calls
      onExit: (_) => allOnExit.forEach((curr) => curr!(_)),
      // ignore: avoid_function_literals_in_foreach_calls
      onEnter: (_) => allOnEnter.reversed.forEach((e) => e!(_)),
      transform: (source) => _applyTransform(source, transformers),
      semanticsLabel: semmanticLabel,
    );
  }

  _applyTransform(
    String source,
    List<String Function(String)?> transformers,
  ) {
    //...
    for (var transformer in transformers) {
      if (transformer == null) continue;
      source = transformer(source);
    }
    return source;
  }

  TextSpan toTextSpans(
    BuildContext context, {
    Markup extraMarkup = const Markup(''),
  }) {
    //...
    final markerUp = MarkupTheme.of(context);
    final fallback = markerUp.builder?.call(context);
    final markup = [fallback ?? const Markup(''), extraMarkup];

    if (children.isEmpty) {
      final style = _mergedStyles(markup);
      final transformed = style?.transform?.call(sample) ?? sample;
      return TextSpan(
        text: transformed,
        style: style?.textStyle,
        recognizer: style?.recognizer,
        onEnter: style?.onEnter,
        onExit: style?.onExit,
        mouseCursor: style?.mouseCursor,
        semanticsLabel: style?.semanticsLabel,
      );
    }
    final spans = <TextSpan>[];

    var lastCharIndex = 0;
    var index = 0;

    while (index < children.length) {
      final style = _mergedStyles(markup);

      final child = children[index];

      if (index == 0 && child.start != lastCharIndex) {
        final text = sample.substring(lastCharIndex, child.start);
        final transformed = style?.transform?.call(text) ?? text;
        spans.add(
          TextSpan(
            text: transformed,
            style: style?.textStyle,
            recognizer: style?.recognizer,
            onEnter: style?.onEnter,
            onExit: style?.onExit,
            mouseCursor: style?.mouseCursor,
            semanticsLabel: style?.semanticsLabel,
          ),
        );
        lastCharIndex = child.start;
        continue;
      }

      if (child.start != lastCharIndex) {
        final text = sample.substring(lastCharIndex, child.start);
        final transformed = style?.transform?.call(text) ?? text;
        spans.add(
          TextSpan(
            text: transformed,
            style: style?.textStyle,
            recognizer: style?.recognizer,
            onEnter: style?.onEnter,
            onExit: style?.onExit,
            mouseCursor: style?.mouseCursor,
            semanticsLabel: style?.semanticsLabel,
          ),
        );
        lastCharIndex = child.start;
        continue;
      }

      if (child.children.isNotEmpty) {
        spans.add(child.toTextSpans(context, extraMarkup: extraMarkup));
        lastCharIndex = child.end;
        index++;
        continue;
      }

      final cstyle = child._mergedStyles(markup);
      final transformed = cstyle?.transform?.call(child.sample) ?? child.sample;
      spans.add(
        TextSpan(
          text: transformed.trim(),
          style: cstyle?.textStyle,
          recognizer: cstyle?.recognizer,
          onEnter: cstyle?.onEnter,
          onExit: cstyle?.onExit,
          mouseCursor: cstyle?.mouseCursor,
          semanticsLabel: cstyle?.semanticsLabel,
        ),
      );
      lastCharIndex = child.end;
      index++;
    }

    final style = _mergedStyles(markup);

    if (lastCharIndex != sample.length - 1) {
      final text = sample.substring(lastCharIndex, sample.length - 1);
      final transformed = style?.transform?.call(text) ?? text;
      spans.add(
        TextSpan(
          text: transformed,
          style: style?.textStyle,
          recognizer: style?.recognizer,
          onEnter: style?.onEnter,
          onExit: style?.onExit,
          mouseCursor: style?.mouseCursor,
          semanticsLabel: style?.semanticsLabel,
        ),
      );
    }

    return TextSpan(
      children: spans,
      style: style?.textStyle,
      recognizer: style?.recognizer,
      onEnter: style?.onEnter,
      onExit: style?.onExit,
      mouseCursor: style?.mouseCursor,
      semanticsLabel: style?.semanticsLabel,
    );
  }
}

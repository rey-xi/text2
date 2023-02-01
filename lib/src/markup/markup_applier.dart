import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'markup.dart';
import 'markup_domain.dart';
import 'markup_theme.dart';
import 'markup_token.dart';

/// ## Markup Applier
/// Via this class, you can apply Markup Tokens
/// to a [sample] string at range from [start]
/// to [end]. An optional [style] can be used to
/// pass in a fallback text style while children
/// appliers can be integrated via [children]
///
/// ```dart
/// ```
class MarkupApplier {
  //...Fields
  /// Range where applier is effective in [sample]
  /// [end ] must be greater than [start].
  int start, end;

  /// A copy of the actual text without markup
  /// literals just text and noting more.
  final String sample;

  /// List of resolved markup tokens that needs
  /// to be applied to [sample] at offsets ranging
  /// from [start] to [end].
  final List<MarkupToken> tokens;

  /// Other sub appliers that applies within range
  /// between [start] and [end]. Children appliers
  /// will also be resolved during [toTextSpans].
  final List<MarkupApplier> children;

  /// A fall back style that will be used for any
  /// unaffected [sample] regions. It will also
  /// serve as underlay for the affected [sample]
  /// regions. <br> ie.
  /// ```dart
  /// sample.subString(start, end);
  /// ```
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
  /// Props are arguments required in encoding our
  /// object to string. Cool right? That's your no
  /// number 1 favourite developer in action.
  List get props => [tokens, start, end, sample, children];

  //...Methods
  @override
  String toString() => mapPropsToString(runtimeType, props);

  /// Convert object to string using type and props
  /// Complicated yet vast: This is damn crazy! Ikr.
  String mapPropsToString(Type type, List<Object?> props) {
    //...
    final args = props.map((prop) => prop.toString());
    return '$type(${args.join(', ')})';
  }

  /// Convert applier to text spans. Just what you
  /// need to get your RichText working. Requires
  /// an active [context] and you can specify extra
  /// or additional [markup] if you wish.
  TextSpan toTextSpans(
    BuildContext context, {
    Markup markup = const Markup(''),
  }) {
    //...
    final markerUp = Theme.of(context).markupTheme;
    final fallback = markerUp.builder?.call(context);
    final markups = [fallback ?? const Markup(''), markup];

    if (children.isEmpty) {
      final style = _mergedStyles(markups);
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
      final style = _mergedStyles(markups);

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
        spans.add(child.toTextSpans(context, markup: markup));
        lastCharIndex = child.end;
        index++;
        continue;
      }

      final cstyle = child._mergedStyles(markups);
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

    final style = _mergedStyles(markups);

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

  String _applyTransform(String src, List<Transformer?> trs) {
    //...
    for (var transformer in trs) {
      if (transformer == null) continue;
      src = transformer(src);
    }
    return src;
  }
}

typedef Transformer = String Function(String);

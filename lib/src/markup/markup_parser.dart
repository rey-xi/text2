import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'markup_applier.dart';
import 'markup_processor.dart';

/// ## Markup Parser
/// Markup parsing algorithm. Parses [text] with an
/// optional [style] for it's fallback text style.
///
/// ```dart
/// MarkupParser(
///   '[bold](text)',
///   style: TextStyle,
/// );
/// ```
class MarkupParser extends Equatable {
  //...Fields
  /// The markup literal to be parsed. This string
  /// can have as many markup modifiers as possible
  final String text;

  /// An optional text style the parser will supply
  /// to [MarkupApplier.style] during [parse]. It
  /// serves as a fallback or underlay for markup
  /// spans. <br> See: [MarkupApplier.toTextSpans]
  final TextStyle? style;

  const MarkupParser(
    this.text, {
    this.style,
  });

  //...Getters
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [text];

  //...Methods
  /// Get parser ready for [parse]. Mainly helps to
  /// ensure unwanted or redundant markup literals
  /// are taken care of prior the markup effect.
  MarkupParser clean() {
    var sample = "[null]($text)";
    final exp = RegExp(r'\)');
    sample = sample.replaceAll(exp, " )");
    return MarkupParser(sample, style: style);
  }

  /// Create markup appliers by parsing through
  /// [text] for markup literals. <br>
  /// See: [MarkupApplier] and [clean]
  /// ```dart
  /// MarkupParser(data, style: style).clean().parse();
  /// ```
  MarkupApplier parse() {
    //...
    String current = text;
    late MarkupApplier lastApplier;
    final appliersMapper = <int, MarkupApplier>{};

    while (true) {
      final appliers = _MarkupParser(
        current,
        applierMap: appliersMapper,
        style: style,
      ).parse();

      if (appliers == null) break;

      int diff = 0;
      for (var applier in appliers) {
        final beforeTrim = current.length;
        current = current.replaceRange(
          applier.start + diff,
          applier.end + diff,
          applier.hashCode.toString(),
        );
        final afterTrim = current.length;

        diff += afterTrim - beforeTrim;

        appliersMapper[applier.hashCode] = applier;
      }

      lastApplier = appliers.first;
    }

    return lastApplier;
  }
}

/// ## Markup Parser Engine
/// Not the main deal, but serves as the base class for
/// the actual markup parsing algorithm. Parses [text]
/// against [applierMap] with a an optional [style] for
/// it's fallback text style.
///
/// ```dart
/// _MarkupParser(
///   '[bold](text)',
///   applierMap: {},
///   style: TextStyle,
/// )
/// ```
class _MarkupParser extends Equatable {
  //...Fields
  final String text;
  final TextStyle? style;
  final Map<int, MarkupApplier> applierMap;

  const _MarkupParser(
    this.text, {
    this.applierMap = const {},
    required this.style,
  });

  //...Getters
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [text];

  //...Methods
  List<MarkupApplier>? parse() {
    //...
    final exp1 = RegExp(
      r'\[([[\s*?\w,.%-]+[:\w,\s?.%-]+?]*)\]\(([\w\s!'
      r':\\.{}$&?><,"/+=-_;*-_=%#@~`^|\u0027]+)\)',
      multiLine: true,
    );
    final exp2 = RegExp(
      r'\[([[\s*?\w,.%-]+[:\w,\s?.%-]+?]*)\]\((('
      r'["\w\s\W\S\u0027])+)\)',
      multiLine: true,
    );
    Iterable<RegExpMatch> match = exp1.allMatches(text);

    if (match.isEmpty) {
      match = exp2.allMatches(text);

      if (match.isEmpty) return null;
    }

    final appliers = <MarkupApplier>[];
    for (var m in match) {
      final sample = m.group(2)!;
      final modifiers = m.group(1)!;
      final tokens = MarkupProcessor(modifiers).parseTokens();
      final children = fetchChildren(sample);
      final applier = MarkupApplier(
        tokens,
        children[1],
        m.start,
        m.end,
        children: children[0],
        style: style,
      );
      appliers.add(applier);
    }

    return appliers;
  }

  List<dynamic> fetchChildren(String sample) {
    //...
    final numExp = RegExp(r"\d+");
    String changed = sample;
    final appliers = <MarkupApplier>[];
    final allMatches = numExp.allMatches(sample);

    for (var match in allMatches) {
      final val = match.group(0);
      if (val == null) continue;
      final style = applierMap[int.parse(val)];
      if (style != null) {
        appliers.add(style);
      }
    }

    for (var applier in appliers) {
      final code = "${applier.hashCode}";
      final index = changed.indexOf(code);
      applier.start = index;
      applier.end = index + code.length;
      changed = changed.replaceRange(
        applier.start,
        applier.end,
        code,
      );
    }

    return [appliers, changed];
  }
}

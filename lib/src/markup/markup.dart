library markup;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

part '../markups/color_markup.dart';
part '../markups/hyperlink_markup.dart';
part '../markups/multi_markup.dart';
part '../markups/shortcut_markup.dart';
part '../markups/size_markup.dart';
part '../markups/theme_markup.dart';
part '../markups/weight_markup.dart';

/// ## Markup
/// The base class that enables [Text2] to span
/// text based on modifiers. Modifiers are in ...
/// string spans that are pre declared via markup
/// instances.
///
/// ```dart
/// Markup(
///    modifiers,
///    styling: (arg) {
///      const x = Colors.transparent;
///      final y = extras?[arg] ?? x;
///      final temp = TextStyle(color: y);
///      return style(arg, temp);
///    },
/// )
/// ```
class Markup {
  //...Fields
  final String modifiers;

  /// build text style based on optional arguments
  ///
  /// example: `hello [color: red]( world )`
  final Styling? styling;

  /// add gesture recognizer for this modifier
  ///
  /// Note: if multiple gesture recognizer overlap
  /// on a single modifier the nearest recognizer
  /// will be chosen.
  final Recognition? recognition;

  /// Transform source string to transformed string.
  ///
  /// Reduces source to a single string by iteratively
  /// transforming source using the provided transform
  /// function.
  ///
  /// NOTE: TRANSFORMERS ARE EXECUTED LEFT TO RIGHT.
  ///
  /// example: "`[t1, t2, t3, t4](hello world)`"
  ///
  /// In the above example, `hello world` is first
  /// transformed by `t1` then the result will be
  /// transformed by `t2` till `t4`;
  ///
  final Transformation? transformation;

  /// build text style based on optional arguments
  /// and resultant effect of predecessor styling
  /// hierarchy.
  ///
  /// structure: `[mod1: arg, mod2](string)`
  ///
  /// example: `hello [color: red]( world )`
  final Refactoring? refactoring;

  /// callback to be called when this modifier is
  /// entered by a pointer.
  ///
  /// Note: if multiple callbacks are overlapping
  /// on single modifier all `onEnter` events will
  /// be called from top-most element to bottom-most.
  final void Function(PointerEnterEvent)? onEnter;

  /// callback to be called when this modifier is
  /// exited by a pointer.
  ///
  /// Note: if multiple callbacks are overlapping on
  /// single modifier all `onExit` events will be
  /// called from bottom-most element to top-most.
  final void Function(PointerExitEvent)? onExit;

  /// mouse cursor for this modifier
  final MouseCursor? mouseCursor;

  /// semantics label for this modifier
  final String? semanticsLabel;

  const Markup(
    this.modifiers, {
    this.styling,
    this.recognition,
    this.refactoring,
    this.transformation,
    this.onEnter,
    this.onExit,
    this.mouseCursor,
    this.semanticsLabel,
  });

  factory Markup.entry(
    String modifiers, {
    TextStyle? style,
    GestureRecognizer? recognizer,
    String Function(String source)? transform,
    TextStyle Function(TextStyle style)? refactor,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
    Iterable<Markup> children = const [],
    MouseCursor? mouseCursor,
    String? semanticsLabel,
  }) {
    return Markup(
      modifiers,
      styling: (_) => style ?? const TextStyle(),
      recognition: recognizer != null ? (_) => recognizer : null,
      transformation: (src, _) => transform?.call(src) ?? src,
      refactoring: (style, _) => refactor?.call(style) ?? style,
      onEnter: onEnter,
      onExit: onExit,
      mouseCursor: mouseCursor,
      semanticsLabel: semanticsLabel,
    );
  }

  //...Methods
  Iterable<String> get modifierList {
    //...
    return modifiers.split(RegExp(r', ?'));
  }

  Map<String, Markup> get spread {
    //..
    final sheet = <String, Markup>{};
    for (var command in modifierList) {
      if (command.isEmpty) continue;
      sheet[command] = this;
    }
    return sheet;
  }
}

typedef Styling = TextStyle Function(String? arg);

typedef Recognition = GestureRecognizer Function(String? arg);

typedef Refactoring = TextStyle Function(TextStyle style, String? arg);

typedef Transformation = String Function(String source, String? arg);

import 'package:flutter/material.dart';

import 'markup.dart';

/// ## Markup Theme
/// A theme extension for the markup library.
/// Can be injected into context via ThemeData
///.extensions or by including as an ancestor
/// to the target Text2 Widget. It supplies a
/// more contextual markup diction that defines
/// how affected text2 markups are implemented.
///
/// ```dart
///  MarkupTheme(
///    builder: (context) {
///       // return markup
///    }
///  );
/// ```
class MarkupTheme extends StatelessWidget
    implements //
        ThemeExtension<MarkupTheme> {
  //...Fields
  /// For more grained control over modifiers
  /// a markup builder is supplied here rather
  /// than a markup itself.
  final MarkupBuilder? builder;

  final Widget? child;

  const MarkupTheme({
    super.key,
    this.builder,
    this.child,
  });

  //...Getters
  @override
  Object get type => MarkupTheme;

  //...Methods
  @override
  MarkupTheme copyWith({
    Markup Function(BuildContext context)? builder,
  }) {
    return MarkupTheme(builder: builder ?? this.builder);
  }

  @override
  MarkupTheme lerp(other, double t) {
    if (other is! MarkupTheme) return this;
    return MarkupTheme(builder: other.builder ?? builder);
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

extension MarkupThemeData on ThemeData {
  //...Getters
  MarkupTheme get markupTheme {
    return extension<MarkupTheme>() ?? const MarkupTheme();
  }
}

typedef MarkupBuilder = Markup Function(BuildContext context);

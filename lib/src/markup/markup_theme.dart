import 'package:flutter/material.dart';

import 'markup.dart';

class MarkupTheme extends StatelessWidget
    implements //
        ThemeExtension<MarkupTheme> {
  //...Fields
  final Markup Function(BuildContext context)? builder;
  final Widget? child;

  const MarkupTheme({
    super.key,
    this.builder,
    this.child,
  });

  factory MarkupTheme.of(BuildContext context) {
    return Theme.of(context).markupTheme;
  }

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

class DefaultMarkupSheet extends MarkupTheme {
  //...Fields
  DefaultMarkupSheet({super.key})
      : super(
          builder: (context) {
            return MultiMarkup({
              SizeMarkup(context),
              DetailMarkup(context),
              ShortcutMarkup(context),
              WeightMarkup(),
              ColorMarkup(),
              HyperlinkMarkup(),
            });
          },
        );
}

extension MarkupThemeData on ThemeData {
  //...Getters
  MarkupTheme get markupTheme {
    return extension<MarkupTheme>() ?? const MarkupTheme();
  }
}

part of markup;

/// ## Default Markup
/// Easily Make use of all inbuilt markups with minimal
/// customisation. [theme] applies to [DetailMarkup],
/// [extraColors] to [ColorMarkup], [extraWeights] to
/// [WeightMarkup] and finally [routes] applies to
/// [HyperlinkMarkup] <br/>
/// See [DefaultMarkupTheme] also.
///
/// ```dart
/// markup: DefaultMarkup(context),
/// ```
class DefaultMarkup extends MultiMarkup {
  //...Fields
  final TextTheme? theme;
  final BuildContext context;
  final Map<String, Color>? extraColors;
  final Map<String, FontWeight>? extraWeights;
  final Map<String, void Function(String?)> routes;

  DefaultMarkup(
    this.context, {
    this.theme,
    this.extraWeights,
    this.extraColors,
    this.routes = const {},
  }) : super([
          SizeMarkup(context),
          ShortcutMarkup(context),
          DetailMarkup(context, theme: theme),
          WeightMarkup(extras: extraWeights),
          ColorMarkup(extras: extraColors),
          HyperlinkMarkup(routes: routes),
        ]);
}

/// ## Default Markup Theme
/// Easily Make use of all inbuilt markup theme with
/// minimal optimisation. Markup theme version of
/// [DefaultMarkup] <br/>
/// See [DefaultMarkup] and [MarkupTheme] also.
///
/// ```dart
/// Theme.of(context).copyWith(
///   extensions: [
///     ...Theme.of(context).extensions.values,
///     DefaultMarkupTheme(theme: Typography.redmond),
///   ]
/// )
/// ```
class DefaultMarkupTheme extends MarkupTheme {
  //...Fields
  final TextTheme? theme;
  final Map<String, Color>? extraColors;
  final Map<String, FontWeight>? extraWeights;
  final Map<String, void Function(String?)> routes;

  DefaultMarkupTheme({
    super.key,
    this.theme,
    this.extraColors,
    this.extraWeights,
    this.routes = const {},
    super.child,
  }) : super(
          builder: (context) {
            return DefaultMarkup(
              context,
              theme: theme,
              extraWeights: extraWeights,
              extraColors: extraColors,
              routes: routes,
            );
          },
        );
}

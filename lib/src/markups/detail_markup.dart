part of markup;

/// ## TextTheme or Detail Markup
/// Markup system for [TextTheme].
///
/// ### Usage
/// Once injected into the context either via themes
/// or inline, supported modifiers are 'detail', and
/// 'theme' by default. Supported argument is a name
/// of any text style in a typical material text theme
///
/// ```markdown
/// [theme: displaySmall](string)
/// [detail: body1](string)
/// [detail: headlineLarge](string)
/// ```
class DetailMarkup extends Markup {
  //...Fields
  DetailMarkup(
    BuildContext context, {
    TextTheme? theme,
    String modifiers = 'detail, theme',
  }) : super(
          modifiers,
          styling: (arg) {
            return style(context, arg, theme);
          },
        );

  static TextStyle style(context, String? arg, [TextTheme? theme]) {
    //...
    theme ??= Theme.of(context).textTheme;
    switch (arg) {
      case "displayLarge":
        return theme.displayLarge ?? const TextStyle();
      case "displayMedium":
        return theme.displayMedium ?? const TextStyle();
      case "displaySmall":
        return theme.displaySmall ?? const TextStyle();
      case "titleLarge":
        return theme.titleLarge ?? const TextStyle();
      case "titleMedium":
        return theme.titleMedium ?? const TextStyle();
      case "titleSmall":
        return theme.titleSmall ?? const TextStyle();
      case "labelLarge":
        return theme.labelLarge ?? const TextStyle();
      case "labelMedium":
        return theme.labelMedium ?? const TextStyle();
      case "labelSmall":
        return theme.labelSmall ?? const TextStyle();
      case "bodyLarge":
        return theme.bodyLarge ?? const TextStyle();
      case "bodyMedium":
        return theme.bodyMedium ?? const TextStyle();
      case "bodySmall":
        return theme.bodySmall ?? const TextStyle();
      case "headlineLarge":
        return theme.headlineLarge ?? const TextStyle();
      case "headlineMedium":
        return theme.headlineMedium ?? const TextStyle();
      case "headlineSmall":
        return theme.headlineSmall ?? const TextStyle();
      case "headline1":
        return theme.displayLarge ?? const TextStyle();
      case "headline2":
        return theme.displayMedium ?? const TextStyle();
      case "headline3":
        return theme.displaySmall ?? const TextStyle();
      case "headline4":
        return theme.headlineMedium ?? const TextStyle();
      case "headline5":
        return theme.headlineSmall ?? const TextStyle();
      case "headline6":
        return theme.titleLarge ?? const TextStyle();
      case "body1":
        return theme.bodyLarge ?? const TextStyle();
      case "body2":
        return theme.bodyMedium ?? const TextStyle();
      case "button":
        return theme.labelLarge ?? const TextStyle();
      case "caption":
        return theme.bodySmall ?? const TextStyle();
      case "subtitle1":
        return theme.titleMedium ?? const TextStyle();
      case "subtitle2":
        return theme.titleSmall ?? const TextStyle();
      case "overline":
        return theme.labelSmall ?? const TextStyle();
      default:
        return const TextStyle();
    }
  }
}

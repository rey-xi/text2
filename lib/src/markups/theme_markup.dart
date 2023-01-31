part of markup;

class DetailMarkup extends Markup {
  //...Fields
  DetailMarkup(
    BuildContext context, {
    TextTheme? presets,
    String modifiers = 'detail',
  }) : super(
          modifiers,
          styling: (arg) {
            return style(context, arg, presets);
          },
        );

  static TextStyle style(context, String? arg, [TextTheme? presets]) {
    //...
    presets ??= Theme.of(context).textTheme;
    switch (arg) {
      case "displayLarge":
        return presets.displayLarge ?? const TextStyle();
      case "displayMedium":
        return presets.displayMedium ?? const TextStyle();
      case "displaySmall":
        return presets.displaySmall ?? const TextStyle();
      case "titleLarge":
        return presets.titleLarge ?? const TextStyle();
      case "titleMedium":
        return presets.titleMedium ?? const TextStyle();
      case "titleSmall":
        return presets.titleSmall ?? const TextStyle();
      case "labelLarge":
        return presets.labelLarge ?? const TextStyle();
      case "labelMedium":
        return presets.labelMedium ?? const TextStyle();
      case "labelSmall":
        return presets.labelSmall ?? const TextStyle();
      case "bodyLarge":
        return presets.bodyLarge ?? const TextStyle();
      case "bodyMedium":
        return presets.bodyMedium ?? const TextStyle();
      case "bodySmall":
        return presets.bodySmall ?? const TextStyle();
      case "headlineLarge":
        return presets.headlineLarge ?? const TextStyle();
      case "headlineMedium":
        return presets.headlineMedium ?? const TextStyle();
      case "headlineSmall":
        return presets.headlineSmall ?? const TextStyle();
      case "headline1":
        return presets.headline1 ?? const TextStyle();
      case "headline2":
        return presets.headline2 ?? const TextStyle();
      case "headline3":
        return presets.headline3 ?? const TextStyle();
      case "headline4":
        return presets.headline4 ?? const TextStyle();
      case "headline5":
        return presets.headline5 ?? const TextStyle();
      case "headline6":
        return presets.headline6 ?? const TextStyle();
      case "body1":
        return presets.bodyText1 ?? const TextStyle();
      case "body2":
        return presets.bodyText2 ?? const TextStyle();
      case "button":
        return presets.button ?? const TextStyle();
      case "caption":
        return presets.caption ?? const TextStyle();
      case "subtitle1":
        return presets.subtitle1 ?? const TextStyle();
      case "subtitle2":
        return presets.subtitle2 ?? const TextStyle();
      case "overline":
        return presets.overline ?? const TextStyle();
      default:
        return const TextStyle();
    }
  }
}

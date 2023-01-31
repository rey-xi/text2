part of markup;

class HyperlinkMarkup extends Markup {
  //...Fields
  HyperlinkMarkup({
    String modifiers = 'href, hyperlink',
    TextStyle style = const TextStyle(),
    Map<String, TapAction>? routes,
    TapAction? onTap,
  }) : super(
          modifiers,
          styling: (arg) {
            final fallback = TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue.shade700,
            );
            return fallback.merge(style);
          },
          recognition: (arg) {
            final callback = routes?[arg] ??
                onTap ??
                (_) {
                  if (kDebugMode) {
                    print('$_ route callback not found!');
                  }
                };
            return TapGestureRecognizer()..onTap = () => callback(arg);
          },
        );
}

typedef TapAction = void Function(String? arg);

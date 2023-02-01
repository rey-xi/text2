part of markup;

/// ## Hyperlink Markup
/// Markup system for [Hyperlinks].
///
/// ### Usage
/// Once injected into the context either via themes
/// or inline, supported modifiers are 'href', and
/// 'hyperlink' by default. Supported argument is
/// either none or any key supported from [routes]
///
/// ```markdown
/// [href](string)
/// [hyper: 0xFFFFFF](string)
/// [color: 15368](string)
/// ```
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

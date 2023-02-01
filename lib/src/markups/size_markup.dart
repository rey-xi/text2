part of markup;

/// ## Size Markup
/// Markup system for [TextStyle.fontSize].
///
/// ### Usage
/// Once injected into the context either via themes
/// or inline, supported modifiers are 'size', or 'sz'
/// by default. Supported argument is a double value
/// either proceeded by 'x', followed by '%' or 'sp',
/// or even nothing.
///
/// ```markdown
/// [size: 24](string) // solid pixel
/// [size: x24](string) // percentage size
/// [size: 24%](string) // percentage size
/// [size: 24sp](string) // solid pixel
/// ```
class SizeMarkup extends Markup {
  //...Fields
  SizeMarkup(
    BuildContext context, {
    String modifiers = 'size, sz',
  }) : super(
          modifiers,
          refactoring: (style, arg) {
            return SizeMarkup.style(context, arg, style);
          },
        );

  static TextStyle style(context, String? arg, [TextStyle? style]) {
    //...
    style = DefaultTextStyle.of(context).style.merge(style);
    if ((arg ?? '').startsWith('x')) {
      final altArg = arg?.replaceAll('x', '');
      final factor = double.tryParse(altArg ?? '') ?? 1.0;
      return TextStyle(fontSize: factor * (style.fontSize!));
    }
    if ((arg ?? '').endsWith('%')) {
      final altArg = arg?.replaceAll('%', '');
      final factor = double.tryParse(altArg ?? '') ?? 1.0;
      return TextStyle(fontSize: factor * (style.fontSize!));
    }
    if ((arg ?? '').endsWith('sp')) {
      final altArg = arg?.replaceAll('sp', '');
      final factor = double.tryParse(altArg ?? '') ?? 1.0;
      return TextStyle(fontSize: factor * (style.fontSize!));
    }
    return TextStyle(fontSize: double.tryParse(arg ?? ''));
  }
}

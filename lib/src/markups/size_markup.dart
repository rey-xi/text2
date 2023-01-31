part of markup;

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
    return TextStyle(fontSize: double.tryParse(arg ?? ''));
  }
}

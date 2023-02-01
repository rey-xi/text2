part of markup;

/// ## Color Markup
/// Markup system for [Color].
///
/// ### Usage
/// Once injected into the context either via themes
/// or inline, supported modifiers are 'color',
/// 'back-color' and 'deco-color' by default. Supported
/// argument is either an hex color code, color integer
/// value, name of a material color, or any key supported
/// from [extras].
///
/// ```markdown
/// [color: blue](string)
/// [color: 0xFFFFFF](string)
/// [color: 15368](string)
/// ```
class ColorMarkup extends MultiMarkup {
  //...Fields
  ColorMarkup({
    String modifiers = 'color',
    String backgroundModifiers = 'back-color',
    String decorationModifiers = 'deco-color',
    Map<String, Color>? extras,
  }) : super([
          Markup(
            modifiers,
            styling: (arg) {
              const x = Colors.transparent;
              final temp = TextStyle(color: extras?[arg] ?? x);
              return style(arg, temp);
            },
          ),
          Markup(
            backgroundModifiers,
            styling: (arg) {
              const x = Colors.transparent;
              final temp = TextStyle(backgroundColor: extras?[arg] ?? x);
              return style(arg, temp);
            },
          ),
          Markup(
            decorationModifiers,
            styling: (arg) {
              const x = Colors.transparent;
              final temp = TextStyle(decorationColor: extras?[arg] ?? x);
              return style(arg, temp);
            },
          ),
        ]);

  static TextStyle style(String? arg, TextStyle template) {
    //...
    Color? color;
    TextStyle result = const TextStyle();
    var value = int.tryParse(arg ?? '');
    if (arg != null && arg.startsWith('0x')) {
      final x = arg.length == 8 ? 'FF' : '';
      value = int.tryParse(
        '$x${arg.substring(2)}',
        radix: 16,
      );
    }
    if (value != null) color = Color(value);
    if (template.color != null) {
      if (template.color != Colors.transparent) {
        result = result.copyWith(
          color: template.color,
        );
      }
      result = result.copyWith(
        color: ColorMarkup.color(arg) ?? color,
      );
    }
    if (template.backgroundColor != null) {
      if (template.backgroundColor != Colors.transparent) {
        result = result.copyWith(
          backgroundColor: template.backgroundColor,
        );
      }
      result = result.copyWith(
        backgroundColor: ColorMarkup.color(arg) ?? color,
      );
    }
    if (template.decorationColor != null) {
      if (template.decorationColor != Colors.transparent) {
        result = result.copyWith(
          decorationColor: template.decorationColor,
        );
      }
      result = result.copyWith(
        decorationColor: ColorMarkup.color(arg) ?? color,
      );
    }
    return result;
  }

  static Color? color(String? arg) {
    switch (arg) {
      case "red":
        return Colors.red;
      case "pink":
        return Colors.pink;
      case "purple":
        return Colors.purple;
      case "deepPurple":
        return Colors.deepPurple;
      case "indigo":
        return Colors.indigo;
      case "blue":
        return Colors.blue;
      case "lightBlue":
        return Colors.lightBlue;
      case "cyan":
        return Colors.cyan;
      case "teal":
        return Colors.teal;
      case "green":
        return Colors.green;
      case "lightGreen":
        return Colors.lightGreen;
      case "lime":
        return Colors.lime;
      case "yellow":
        return Colors.yellow;
      case "amber":
        return Colors.amber;
      case "orange":
        return Colors.orange;
      case "deepOrange":
        return Colors.deepOrange;
      case "brown":
        return Colors.brown;
      case "grey":
        return Colors.grey;
      case "blueGrey":
        return Colors.blueGrey;
      case "white":
        return Colors.white;
      case "black":
        return Colors.black;
      default:
        return null;
    }
  }
}

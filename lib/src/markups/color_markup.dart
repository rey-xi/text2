part of markup;

class ColorMarkup extends MultiMarkup {
  //...Fields
  ColorMarkup({
    String modifiers = 'color',
    String backgroundModifiers = 'bColor',
    String decorationModifiers = 'dColor',
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
    final value = int.tryParse(arg ?? '');
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

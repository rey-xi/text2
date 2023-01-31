part of markup;

class WeightMarkup extends Markup {
  //...Fields
  WeightMarkup({
    String modifiers = 'weight, w',
    Map<String, FontWeight>? extras,
  }) : super(
          modifiers,
          styling: (arg) {
            return style(arg).copyWith(
              fontWeight: extras?[arg ?? ''],
            );
          },
        );

  static TextStyle style(String? arg) {
    //...
    switch (arg) {
      case "100":
        return const TextStyle(fontWeight: FontWeight.w100);
      case "200":
        return const TextStyle(fontWeight: FontWeight.w200);
      case "300":
        return const TextStyle(fontWeight: FontWeight.w300);
      case "400":
        return const TextStyle(fontWeight: FontWeight.w400);
      case "500":
        return const TextStyle(fontWeight: FontWeight.w500);
      case "600":
        return const TextStyle(fontWeight: FontWeight.w600);
      case "700":
        return const TextStyle(fontWeight: FontWeight.w700);
      case "800":
        return const TextStyle(fontWeight: FontWeight.w800);
      case "900":
        return const TextStyle(fontWeight: FontWeight.w900);
      case "thick":
        return const TextStyle(fontWeight: FontWeight.w600);
      case "bold":
        return const TextStyle(fontWeight: FontWeight.bold);
      case "thin":
        return const TextStyle(fontWeight: FontWeight.w300);
      case "emphasis":
        return const TextStyle(fontWeight: FontWeight.w900);
      default:
        return const TextStyle(fontWeight: null);
    }
  }
}

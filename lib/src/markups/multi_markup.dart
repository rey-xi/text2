part of markup;

class MultiMarkup implements Markup {
  //...Fields
  final Iterable<Markup> children;

  const MultiMarkup(this.children);

  @override
  Iterable<String> get modifierList => {};

  @override
  String get modifiers => '';

  @override
  MouseCursor? get mouseCursor => null;

  @override
  void Function(PointerEnterEvent p1)? get onEnter => null;

  @override
  void Function(PointerExitEvent p1)? get onExit => null;

  @override
  Recognition? get recognition => null;

  @override
  Refactoring? get refactoring => null;

  @override
  String? get semanticsLabel => '';

  @override
  Styling? get styling => null;

  @override
  Transformation? get transformation => null;

  @override
  Map<String, Markup> get spread {
    //..
    final sheet = <String, Markup>{};
    if (children.isNotEmpty) {
      for (var style in children) {
        sheet.addAll(style.spread);
      }
    }
    return sheet;
  }
}

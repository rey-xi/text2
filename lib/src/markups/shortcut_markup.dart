part of markup;

/// ## Shortcut Markup
/// Easily markup your Text 2.0 contents in one word
///
/// ### Usage
/// Once injected into the context either via themes
/// or inline, supported modifiers are 'bold', 'thick',
/// 'thin', 'emphasis', 'dwarf', 'short', 'tall', 'grand',
/// 'giant', 'italic', 'underline', 'strike', 'overline',
/// 'wavyLine', 'doubleLine', 'dashedLine', 'dottedLine',
/// 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'body' and 'title'.
///
/// ```markdown
/// [title, bold, grand](string)
/// ```
class ShortcutMarkup extends MultiMarkup {
  //...Fields
  ShortcutMarkup(BuildContext context)
      : super([
          Markup.entry(
            'bold',
            style: WeightMarkup.style('bold'),
          ),
          Markup.entry(
            'thick',
            style: WeightMarkup.style('thick'),
          ),
          Markup.entry(
            'thin',
            style: WeightMarkup.style('thin'),
          ),
          Markup.entry(
            'emphasis',
            style: WeightMarkup.style('emphasis'),
          ),
          Markup.entry(
            'dwarf',
            refactor: (style) {
              return SizeMarkup.style(context, '.35%', style);
            },
          ),
          Markup.entry(
            'short',
            refactor: (style) {
              return SizeMarkup.style(context, '.85%', style);
            },
          ),
          Markup.entry(
            'tall',
            refactor: (style) {
              return SizeMarkup.style(context, '1.25%', style);
            },
          ),
          Markup.entry(
            'grand',
            refactor: (style) {
              return SizeMarkup.style(context, '2.1%', style);
            },
          ),
          Markup.entry(
            'giant',
            refactor: (style) {
              return SizeMarkup.style(context, '1.85%', style);
            },
          ),
          Markup.entry(
            'italic',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          Markup.entry(
            'underline',
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          Markup.entry(
            'strike',
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Markup.entry(
            'overline',
            style: const TextStyle(
              decoration: TextDecoration.overline,
            ),
          ),
          Markup.entry(
            'wavyLine',
            style: const TextStyle(
              decorationStyle: TextDecorationStyle.wavy,
            ),
          ),
          Markup.entry(
            'dashedLine',
            style: const TextStyle(
              decorationStyle: TextDecorationStyle.dashed,
            ),
          ),
          Markup.entry(
            'dottedLine',
            style: const TextStyle(
              decorationStyle: TextDecorationStyle.dotted,
            ),
          ),
          Markup.entry(
            'doubleLine',
            style: const TextStyle(
              decorationStyle: TextDecorationStyle.double,
            ),
          ),
          Markup.entry(
            'h1',
            style: DetailMarkup.style(context, 'headline1'),
          ),
          Markup.entry(
            'h2',
            style: DetailMarkup.style(context, 'headline2'),
          ),
          Markup.entry(
            'h3',
            style: DetailMarkup.style(context, 'headline3'),
          ),
          Markup.entry(
            'h4',
            style: DetailMarkup.style(context, 'headline4'),
          ),
          Markup.entry(
            'h5',
            style: DetailMarkup.style(context, 'headline5'),
          ),
          Markup.entry(
            'h6',
            style: DetailMarkup.style(context, 'headline6'),
          ),
          Markup.entry(
            'body',
            style: DetailMarkup.style(context, 'bodyText2'),
          ),
          Markup.entry(
            'title',
            style: DetailMarkup.style(context, 'titleMedium'),
          ),
        ]);
}

# Markup

A powerful yet easy to use plugin to style text effectively
and efficiently in Flutter.

## Getting Started

`pubspec.yaml`

### Add super text to pubspec.yaml file

```yaml
...
environment:
  sdk: ">=2.12.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  markup:
    git: https://github.com/rey-xi/markup.git 
...
```

## Usage

#### Markup

A theme extension for the markup library. Can be injected into
context via ThemeData.extensions or by including as an ancestor
to the target Text2 Widget. It supplies a more contextual markup
diction that defines how affected text2 markups are implemented.

###### Example:
```dart
  Widget build(BuildContext context) {
  //...
  return MaterialApp(
    title: 'Text2',
    theme: ThemeData(primarySwatch: Colors.blue),
    extensions: [
      MarkupTheme(
        builder: (context) {
          return MultiMarkup({
            SizeMarkup(context),
            DetailMarkup(context),
            ShortcutMarkup(context),
            WeightMarkup(),
            ColorMarkup(
              extras: {
                'primary': context.colors.primary,
                'foreground': context.colors.foreground,
                'background': context.colors.background,
                'secondary': context.colors.secondary,
                'ascent': context.colors.ascent,
                'primal': context.colors.primal,
              },
            ),
            HyperlinkMarkup(
              style: TextStyle(
                color: context.colors.secondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          });
        },
      ),
    ],
  );
}
```


#### Markup Theme

A theme extension for the markup library. Can be injected into
context via ThemeData.extensions or by including as an ancestor
to the target Text2 Widget. It supplies a more contextual markup
diction that defines how affected text2 markups are implemented.

###### Example:
```dart
  Widget build(BuildContext context) {
  //...
  return MaterialApp(
    title: 'Text2',
    theme: ThemeData(primarySwatch: Colors.blue),
    extensions: [
      MarkupTheme(
        builder: (context) {
          return MultiMarkup({
            SizeMarkup(context),
            DetailMarkup(context),
            ShortcutMarkup(context),
            WeightMarkup(),
            ColorMarkup(
              extras: {
                'primary': context.colors.primary,
                'foreground': context.colors.foreground,
                'background': context.colors.background,
                'secondary': context.colors.secondary,
                'ascent': context.colors.ascent,
                'primal': context.colors.primal,
              },
            ),
            HyperlinkMarkup(
              style: TextStyle(
                color: context.colors.secondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          });
        },
      ),
    ],
  );
}
```


## Working Example

```dart
import 'package:flutter/material.dart';
import 'package:super_text/super_text.dart';

class ParagraphWithSuperText extends StatelessWidget {
  const ParagraphWithSuperText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text2("[style:headline3](Text 2.0)"),
            SizedBox(height: 20.0),
            SelectableText2(
              "[bold](Note): There is a way to download a custom font"
              " along with a webpage, to allow you to customize your "
              "font usage in any way you want: [bold](web fonts). This"
              " is a little bit more complex, and we will discuss it in a"
              " [href:open_link, color:black](separate article) later on"
              " in the module.",
            ),
          ],
        ),
      ),
    );
  }
}

```

### Thanks
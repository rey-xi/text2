# Markup

A powerful yet easy to use plugin to markup text effectively
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

#### Text 2.0 

Advanced text widget with markups and modifiers. Provides most 
features already found in material Text but with extra spice of
markup implementation.


#### Selectable Text 2.0

Advanced selectable text widget with markups and modifiers. Provides
most features already found in material SelectableText but with extra
spice of markup implementation.


#### Text 2.0 Theme

Just a slight upgrade to StructStyle. Gives additional access to 
predefine Markups along side other core features of a StructStyle.


#### Markup

The base class that enables Text2 to span text based on modifiers.
Modifiers are in ... string spans that are pre declared via markup 
instances.

###### Example:
```dart
Markup get markup {
  //...
  return Markup(
      modifiers,
      styling: (arg) {
        const x = Colors.transparent;
        final color = extras?[arg] ?? x;
        final temp = TextStyle(color: color);
        return style(arg, temp);
      },
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
            markup: DefaultMarkup(context),
          ],
        ),
      ),
    );
  }
}
```

### Thanks
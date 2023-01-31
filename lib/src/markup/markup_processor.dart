import 'package:equatable/equatable.dart';

import 'markup_token.dart';

class MarkupProcessor extends Equatable {
  //...Fields
  final String modifiers;

  const MarkupProcessor(this.modifiers);

  //...Getters
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [modifiers];

  //...Methods
  List<MarkupToken> parseTokens() {
    final rTokens = modifiers.split(",").map((e) => e.trim());
    final tokens = <MarkupToken>[];

    for (var t in rTokens) {
      final multiValueChecked = splitMultiValue(t).toList();

      late MarkupToken token;

      if (multiValueChecked.length > 1) {
        token = MarkupToken(
          multiValueChecked.first,
          modifier: multiValueChecked.last,
        );
      } else {
        token = MarkupToken(multiValueChecked.first);
      }

      tokens.add(token);
    }

    return tokens;
  }

  Iterable<String> splitMultiValue(String sample) {
    return sample.split(":").map((e) => e.trim());
  }
}

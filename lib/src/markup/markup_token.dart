import 'package:equatable/equatable.dart';

/// ## Markup Token
class MarkupToken extends Equatable {
  //...Fields
  final String code;
  final String? modifier;

  const MarkupToken(this.code, {this.modifier});

  //...Getters
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [code, modifier];

  //...Methods
  @override
  String toString() {
    return "$code : $modifier";
  }
}

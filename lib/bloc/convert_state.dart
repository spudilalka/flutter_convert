import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

class ConvertState extends Equatable {
  final String format;

  const ConvertState({
    this.format = '',
  });
  ConvertState copyWith({
    String? format,
    int? counter,
    Color? bgColor,
  }) {
    return ConvertState(
      format: format ?? this.format,
    );
  }

  @override
  List<Object?> get props => [
        format,
      ];
}

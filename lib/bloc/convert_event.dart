import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ConvertEvent {
  const ConvertEvent();
  @override
  List<Object?> get props => [];
}

class PickFile extends ConvertEvent {
  final String filename;
  final String filePath;
  const PickFile({required this.filePath, required this.filename});
}

class Wordformat extends ConvertEvent {
  final String format;
  const Wordformat({required this.format});
}

class Txtformat extends ConvertEvent {
  final String format;
  const Txtformat({required this.format});
}

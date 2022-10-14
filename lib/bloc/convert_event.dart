import 'package:equatable/equatable.dart';

abstract class ConvertEvent extends Equatable {
  const ConvertEvent();
  @override
  List<Object?> get props => [];
}

class PNGformat extends ConvertEvent {
  final String format;
  const PNGformat({required this.format});
}

class Wordformat extends ConvertEvent {
  final String format;
  const Wordformat({required this.format});
}

class Txtformat extends ConvertEvent {
  final String format;
  const Txtformat({required this.format});
}

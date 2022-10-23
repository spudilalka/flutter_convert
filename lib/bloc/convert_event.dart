import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ConvertEvent {
  const ConvertEvent();
  @override
  List<Object?> get props => [];
}

class GetFile extends ConvertEvent {
  
  const GetFile();
}

class Check extends ConvertEvent {
  const Check();
}

class PickFile extends ConvertEvent {
  const PickFile();
}

class SetNewFileFormat extends ConvertEvent {
  final String NewFormat;

  const SetNewFileFormat({
    required this.NewFormat,
  });
}

class PickName extends ConvertEvent {
  final String newName;

  const PickName({
    required this.newName,
  });
}

class PickNewFilePath extends ConvertEvent {
  const PickNewFilePath();
}

class PickNewFormat extends ConvertEvent {
  final String newFileFormat;
  const PickNewFormat({
    required this.newFileFormat,
  });
}

import 'dart:ffi';

import 'package:cloudconvert_client/cloudconvert_client.dart';
import 'package:equatable/equatable.dart';

class ConvertState extends Equatable {
  // final Client newclient;
  final String newFileFormat;
  final String filename;
  final List<String> availableFormats;
  final String url;
  final String newFilename;
  final String filePath;
  final String newFilePath;
  final String exeption1;
  final String exeption2;
  final String exeption3;
  final String exeption4;
  final bool isButtonActive;
  final String isAct;

  const ConvertState({
    this.filename = 'выбор файла',
    this.newFileFormat = 'example',
    this.availableFormats = const [],
    this.newFilename = 'new_file',
    this.filePath = '',
    this.url = '',
    this.newFilePath = '',
    this.exeption1 = '',
    this.exeption2 = '',
    this.exeption3 = '',
    this.exeption4 = '',
    this.isButtonActive = true,
    this.isAct = 'true',
  });

  ConvertState copyWith({
    String? filename,
    String? newFileFormat,
    List<String>? availableFormats,
    String? url,
    String? newFilename,
    String? filePath,
    String? newFilePath,
    String? exeption1,
    String? exeption2,
    String? exeption3,
    String? exeption4,
    bool? isButtonActive,
    String? isAct,
  }) {
    return ConvertState(
      filename: filename ?? this.filename,
      newFileFormat: newFileFormat ?? this.newFileFormat,
      availableFormats: availableFormats ?? this.availableFormats,
      url: url ?? this.url,
      newFilename: newFilename ?? this.newFilename,
      filePath: filePath ?? this.filePath,
      newFilePath: newFilePath ?? this.newFilePath,
      exeption1: exeption1 ?? this.exeption1,
      exeption2: exeption2 ?? this.exeption2,
      exeption3: exeption3 ?? this.exeption3,
      exeption4: exeption4 ?? this.exeption4,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      isAct: isAct ?? this.isAct,
    );
  }

  @override
  List<Object?> get props => [
        newFileFormat,
        newFilename,
        newFilePath,
        availableFormats,
        url,
        filePath,
        filename,
        exeption1,
        exeption2,
        exeption3,
        exeption4,
        isButtonActive,
        isAct,
      ];
}

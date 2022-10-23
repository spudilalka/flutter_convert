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

  const ConvertState({
    //this.newclient = null;
    this.filename = 'выбор файла',
    this.newFileFormat = 'выбор формата',
    this.availableFormats = const [],
    this.newFilename = '',
    this.filePath = '',
    this.url = '',
  });

  ConvertState copyWith({
    String? filename,
    String? newFileFormat,
    List<String>? availableFormats,
    String? url,
    String? newFilename,
    String? filePath,
  }) {
    return ConvertState(
      filename: filename ?? this.filename,
      newFileFormat: newFileFormat ?? this.newFileFormat,
      availableFormats: availableFormats ?? this.availableFormats,
      url: url ?? this.url,
      newFilename: newFilename ?? this.newFilename,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  List<Object?> get props => [
        newFileFormat,
      ];
}

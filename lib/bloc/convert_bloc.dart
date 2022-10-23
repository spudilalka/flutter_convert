import 'convert_event.dart';
import 'convert_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloudconvert_client/cloudconvert_client.dart';
import 'package:file_picker/file_picker.dart';

class ConvertBloc extends Bloc<ConvertEvent, ConvertState> {
  ConvertBloc() : super(const ConvertState()) {
    on<ConvertEvent>((event, emit) async {
      if (event is PickFile) {
        await pickFile(event, state, emit);
      } else if (event is PickNewFilePath) {
        await pickPath(event, state, emit);
      } else if (event is PickName) {
        await setNewFileName(event, state, emit);
      } else if (event is SetNewFileFormat) {
        await setNewFileFormat(event, state, emit);
      } else if (event is GetFile) {
        await getFile(event, state, emit);
      }
    });
  }

  Client newclient = Client(
    apiKey:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMTdhNmI3ZDYxMjdjYTlmYzJlNmRjNWUzNWJkMDlhYjdjOWY5MjJhMTc1MTU2MjcxYmFjNzg2ZDgzZjIwZTRhOTViY2FiYjJiNTg3OTdmYmMiLCJpYXQiOjE2NjU5NTgwNDEuNzY1OTIsIm5iZiI6MTY2NTk1ODA0MS43NjU5MjIsImV4cCI6NDgyMTYzMTY0MS43NjMxMDUsInN1YiI6IjYwMzEzMzUxIiwic2NvcGVzIjpbInVzZXIucmVhZCIsInVzZXIud3JpdGUiLCJ0YXNrLnJlYWQiLCJ0YXNrLndyaXRlIiwid2ViaG9vay5yZWFkIiwid2ViaG9vay53cml0ZSIsInByZXNldC5yZWFkIiwicHJlc2V0LndyaXRlIl19.RHLXajuQXxQf8kos6Qf70sH--QpRdK-6xeZybiQTpajiNknI_NsVGUGUyToX53AayyJiDDA4BQOan-oJCq6hIIfXJMpJLtBuPH1mlnfBd8o_5MToCu25S0hB1NagqjNoEqY0uX9XAbV13U4dbP-vUcbo-BPsXzteLrwAo2OL09vy0p5Vlgoiz4AI4q33SppMOy3JSZp95fdWqbfFYoIdNnQtbqUbX28jqMG8gOCaEUeWPywg0mVABcWu1vcUnSxA9_DUxtPo2gvVqpQRG-Q6VhqClCiCiWIyzCK6SPQEj0zjz1IL6l5Vs73gnqLTo4EBQCpkahTFMRDVenvfUEdXfcjaaF_TcIa_bcJ1dCMvzzWgY9qUrzroo8QVgpdt4OTi4QAylMi4aYdcQTodvbsepoo3hRrm8a23hBCB-S-4hA8wP-Sxh48yI6y02XH_I2MYGAkXvrcdgas2wIneNeanypwOKl3zfUqnmGq-2w31IsFt8oDf9gs7jjWQ0YfYaDQdsodIpCqsNOGc24NlrZyD3emV4q8cNkw-KY6kTLlLBRTnKVxS9mSdsPm3605sGdCcCjUHuGAHS8V4A-KotSqlT2ISC3dtABcMwTXhOdBidRj4a8Bfs5tTu7rLx3MMsC_xyt4VrcLbmNqVy0yAkDY9Sk7YEdE0oCZq1okThC8xPLc",
    baseUrls: BaseUrls.sandbox,
  );

  Future setNewFileFormat(
    SetNewFileFormat event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    emit(state.copyWith(newFileFormat: event.NewFormat));
  }

  Future<void> setNewFileName(
    PickName event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    emit(state.copyWith(newFilename: event.newName));
  }

  Future pickPath(
    PickNewFilePath event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    final path = await FilePicker.platform.getDirectoryPath();
    print(path);
    emit(state.copyWith(
      newFilePath: path,
    ));
  }

  Future getFile(
    GetFile event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    ConverterResult url =
        (await newclient.postJob(state.filePath, state.newFileFormat));
    if (url.exception != null) {
      print(url.exception);
      emit(state.copyWith(
        exeption1: url.exception.toString(),
      ));
    } else {
      print(url.result);
      emit(state.copyWith(
        url: url.result,
      ));
    }
    ConverterResult response = await newclient.downloadResult(
      url.result,
      state.newFilename,
      state.newFileFormat,
      state.newFilePath,
    );
    if (response.exception != null) {
      print(response.exception);
    } else {
      print('kk');
    }
  }

  Future pickFile(
    PickFile event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;

    final ConverterResult formats =
        await newclient.getSupportedFormats(result.files.first.path.toString());
    if (formats.exception == null) {
      List<String> list = formats.result;
      print('fileName = ' + result.files.first.name);
      print('filePath = ' + result.files.first.path.toString());

      emit(state.copyWith(
        filename: result.files.first.name,
        filePath: result.files.first.path,
        availableFormats: list,
      ));
    } else {
      emit(state.copyWith(
        exeption1: formats.exception.toString(),
      ));
    }
  }
}

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
  bool isActive = true;
  Client newclient = Client(
    apiKey:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODE5ZmIwMWQxMGE2ZmY0OTNiNDVkMzhlMzc1NzcwZTA1M2RlNGYxMmVhODY5OWE0YjcyMWVhMzNlMTc5NTk4NTQ1MmM0NzQwNzZjMDg5OWYiLCJpYXQiOjE2NjY2Mjk5NzUuMTUzNjI3LCJuYmYiOjE2NjY2Mjk5NzUuMTUzNjI4LCJleHAiOjQ4MjIzMDM1NzUuMTQ4NjIxLCJzdWIiOiI2MDMxMzM1MSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.iC5mH0UVTyNmCRigNbegZp6i64nrYBvRvDymK8rEG2-UZErLAHThsWkys3sxdLai-UGoe_cAhsmGp_NfnK8hoDgmOnJ5xhMGSUDhIKUCfTuuMbnf2-NcuToTmgzc0Ps4D2FT3Bqi3wTOrvfXlZdo41GoyPZ1b2h9AhYFyCk6gw58I0iAdB4xL1PcFLNwYDVgrZqS2ueb4KNCCpVKlDkrz1lCR8k3LoITMszCi5hhxeN_yGP2R7wYqd3aMbh6v2rB5SCgtQQUxVsH7sXiWCykroZ3l0rAqt2k-U_WSs0b4FPeKVABoKdkCu6K94Ketg6ASj_qkALOUQYvnHaLG7gWY-b9EMcf8B0sOIjR7dN2vKoYV_Amfg1vG3PLbncN9PbVQ_LVNUp6KKaPFt0AwJgRgXOBvq9ytJwOoigdHjOhy1wUE40uSg1_JoBoHcWJQTQm8and_ecErHjzz3fl3C7796SAOe8n5lcbwXVITzFPdke7NNGYa_VthaQ_1nOr8xuDR8d-O-xQyP1fAu7G3JXGOIPYT3QQy9Hxj4KE_4tnLmzrrhJ00ArDYUHZ0PN6SubVsP3jakSpEKWNwljjmg2uRXkQxUj2nOLjnm1hFLWJu9RYQV1S4wwjJiUqBpoGzCgVcovJTD0TUDK76odi4oIoDTAzjaQoIaU7xl_ycDtDKsA",
    baseUrls: BaseUrls.live,
  );

  Future setNewFileFormat(
    SetNewFileFormat event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    if (state.newFileFormat == '' && event.NewFormat == '') {
      emit(state.copyWith(exeption2: 'выберите новый формат!'));
    } else {
      emit(state.copyWith(
        newFileFormat: event.NewFormat,
        exeption2: '',
      ));
      print('exept2 ==' + state.exeption2);
    }
  }

  Future<void> setNewFileName(
    PickName event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    if (event.newName == '' && state.newFilename == '') {
      emit(state.copyWith(
          newFilename: event.newName, exeption4: 'веберите имя!!'));
    } else {
      emit(state.copyWith(newFilename: event.newName, exeption4: ''));
    }
  }

  Future pickPath(
    PickNewFilePath event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    final path = await FilePicker.platform.getDirectoryPath();
    print(path);
    if (path == '') {
      emit(state.copyWith(exeption3: 'выберите путь!!'));
    } else {
      emit(state.copyWith(
        newFilePath: path,
        exeption3: '',
      ));
    }
  }

  Future getFile(
    GetFile event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    if (state.filename == 'выбор файла' ||
        state.filename == '' ||
        state.filePath == '') {
      emit(state.copyWith(
        exeption1: 'выберите  файл!',
      ));
      return;
    } else if (state.newFileFormat == '' || state.newFileFormat == 'example') {
      emit(state.copyWith(
        exeption2: 'выберите  формат!',
      ));
      return;
    } else if (state.newFilePath == '') {
      emit(state.copyWith(
        exeption3: 'выберите  путь для сохранения!',
      ));
      return;
    } else if (state.newFilename == '' || state.newFilename == 'new_file') {
      emit(state.copyWith(
        exeption4: 'выберите  новое имя файла!',
      ));
      return;
    }
    if (isActive == true) {
      isActive = false;
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
        emit(state.copyWith(
          filename : 'выбор файла',
          newFileFormat : 'example',
          availableFormats : const [],
          newFilename : 'new_file',
          filePath :'',
          url : '',
          newFilePath : '',
          exeption1 : '',
          exeption2 : '',
          exeption3 : '',
          exeption4 : '',
        ));
      }
      isActive = true;
    } else {
      print('ne rabotaet');
      return;
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
        exeption1: '',
      ));
    } else {
      emit(state.copyWith(
        exeption1: 'выберите новый фйайл',
      ));
    }
  }
}

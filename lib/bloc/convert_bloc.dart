import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../History/dataBase.dart';
import 'convert_event.dart';
import 'convert_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloudconvert_client/cloudconvert_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

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
      } else if (event is SetLoad) {
        await setLoad(event, state, emit);
      }
    });
  }
  bool isActive = true;
  Client newclient = Client(
    apiKey:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWU5NWJjZDMwYjEwZjhhNTk0NjZmN2NiYWVmNTNhZDA3MzhiZjM5N2Q1NjY4NDBjNDAzYWRhMjhjNzZkMjA3N2ExZmYyMmE1M2RlY2U3N2IiLCJpYXQiOjE2Njc5MjM1MTUuNjA0MTk0LCJuYmYiOjE2Njc5MjM1MTUuNjA0MTk1LCJleHAiOjQ4MjM1OTcxMTUuNTk2OTA5LCJzdWIiOiI2MDMxMzM1MSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.MFBTZLpU9Q6raVng61x8ilPsbGSNrS3Txys2Qluv10PaOnEtQF_emmpkwMev625lUl0ELAVrmstmwrAR3PkU_jTdpCAkyukVfGOD69KMUZE5QJw-UU6RVqs0aPyXzlIDMQVNWd1i7zryVw28VgsjbwtnMvE1S78Xc2tT-XetLJg_YjflJK1n0XOBpg_tQmDdMNLbPRwEr0RrSa8RFrY9PuRCUxNXLqk85ChQqGe65Bk0TcRpQb_kwF_iT7uaefToIdHIYUzs-IZ7smAFrkNeRzOcBsMPGZYzG5HjfRd5rlvMRyf87ZNnYxy_LcDTV6ZDQZCL6y79_V3RwAahWPbJhCJLWRLRUPcYlJqIVDG6nDnW4d-r6kC3cngvkMs44o0ZXAJ5n_9Ov37k6v3i8fMhsHwkrccofPnyCPzNKh0afSvsU4PxMppUBf35o4KlU33xqZzYA9L5aicE6V4-TtDWL-mxRyRyk1EgP4bUtxv_URmScPrD_hspWIK4jzOGIjRu1xvwAbPSx7NiF072IRCp1YJIxd--V0l5PkMnIT0ZMGtIkU-ieA9PBTDbx50vfZxzhQjE24JBYO55xSKzznE-dR6ltJi1wwirHS_799-gX6uaCQwUG7iYzDhwu71kA0TQYCQFCtvKIaoZQmPoVGdB_Xto6pWZhW_HbFtX3XJxBKE",
    baseUrls: BaseUrls.live,
    // apiKey:
    //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzNlNzI3MmI2YTE2MGZiMTA5MWQ5ZDNjYzQxOWFjMjJiZDI0NTExZmRiYjAwNTE0YjA4ODk0NmFmMGZhZWIxNzZlNjc1ZjU3ZDIwOWI4YjciLCJpYXQiOjE2Njc2NTQ0ODguODkxMjA1LCJuYmYiOjE2Njc2NTQ0ODguODkxMjA3LCJleHAiOjQ4MjMzMjgwODguODc4MTAzLCJzdWIiOiI2MDMxMzM1MSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.L6Xfz8cz-tarjH6-LP00IN-S7xCEY6Ex5tkgIpkbR6dV9Mg8bsN4iGtq5VaVwmnVk3tdEx8CwbgkrRdKotSgQvsws0mNaNU3AoQkl-wYulDMrSO1hv9M5oat5JPwdLwHFrWZyyAQI1GL2o-KUnA8cPe-K_waSAZVWBAnNG8J_I4JyFUvUnDjr_0RHl_uG0JdWpujUncPeIEVzcPf77PyQgEtcpWB16HGkOyEm_e09Gsi_2bl02PTFUOSMCUJiVkkxqUiKYHlDRkAVJ5PoPGZFQoUWIbClwoJO2MtbJ2NMhaTTfz1pb3sZa72yPQOIjGQOWZ1a43r5RqSCTlL0nJ3E-5d4Hj_YCxSwzOPJ2L8QvUJZFKlPtGJZNQ14AcIKDzlD8RoUK8C6KBw7TWDhoLdBDZRNSqxipOaiJGATjT9Fvo9SGam1DLgp9DfDbdXQ48h4q4BO_siRHSoqAGDwAWao3AuCNhI-8lpfFtph3APdBmf-4InqqI1TuDGipubyuH0ezqm4ma9GCkokxsHHrwa2w9bdt-vC1XALeKFWZPZIuEny4XYehrg8bLd31IerSiu5sAGZ3Lck1-5axtQ1ieuQuwDKdLm3OlbfQS-Aa6XY5SK3GSqKw5PFAuSJVV22_7nh01yYzJQW9GzAtiqsGy2h8dxyPHuEXW5UZhuG5S1W5Q",
    // baseUrls: BaseUrls.sandbox,
  );

  Future setLoad(
    SetLoad event,
    ConvertState state,
    Emitter<ConvertState> emit,
  ) async {
    if (event.a == true) {
      emit(state.copyWith(
        load: 1,
      ));
      return;
    } else {
      emit(state.copyWith(
        load: 0,
      ));
      return;
    }
  }

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
        load: 0,
      ));
      return;
    } else if (state.newFileFormat == '' || state.newFileFormat == 'new format') {
      emit(state.copyWith(
        exeption2: 'выберите  формат!',
                load: 0,

      ));
      return;
    } else if (state.newFilePath == '') {
      emit(state.copyWith(
        exeption3: 'выберите  путь для сохранения!',
                load: 0,

      ));
      return;
    } else if (state.newFilename == '' || state.newFilename == 'new_file') {
      emit(state.copyWith(
        exeption4: 'выберите  новое имя файла!',
                load: 0,

      ));
      return;
    }
    if (isActive == true) {
      isActive = false;
      ConverterResult url =
          (await newclient.postJob(state.filePath, state.newFileFormat));
      if (url.exception != null) {
        print(url.exception.toString());
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
        final _myBox = Hive.box('hist');

        histDataBase db = new histDataBase();
        db.loadData();
        db.histList.add([
          url.result,
          state.newFilename,
          state.newFileFormat,
        ]);
        db.updateData();

        emit(state.copyWith(
          filename: 'выбор файла',
          newFileFormat: 'new format',
          availableFormats: const [],
          newFilename: 'new_file',
          filePath: '',
          url: '',
          newFilePath: '',
          exeption1: '',
          exeption2: '',
          exeption3: '',
          exeption4: '',
          load: 0,
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

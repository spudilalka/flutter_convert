import 'package:hive/hive.dart';

class histDataBase {
  List histList = [];
  dynamic url;
  final _myBox = Hive.box('hist');

  void craeteInitialData() {
    histList = [
      [url, 'name', 'format', 'path'],
      [url, 'name1', 'format', 'path'],
    ];
    histList.add([url, 'namezz', 'format', 'path']);
    //histList[histList.length + 1] = [url, 'name', 'format', 'path'];
  }

  void loadData() {
    histList = _myBox.get('HISTDATA');
  }

  void updateData() {
    _myBox.put('HISTDATA', histList);
  }
}

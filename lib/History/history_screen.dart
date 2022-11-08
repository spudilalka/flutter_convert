import 'package:cloudconvert_client/cloudconvert_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dataBase.dart';

class HistScreen extends StatefulWidget {
  const HistScreen({Key? key}) : super(key: key);
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

void loadFile(int index, histDataBase dat) async {
  Client newclient = Client(
    apiKey:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWU5NWJjZDMwYjEwZjhhNTk0NjZmN2NiYWVmNTNhZDA3MzhiZjM5N2Q1NjY4NDBjNDAzYWRhMjhjNzZkMjA3N2ExZmYyMmE1M2RlY2U3N2IiLCJpYXQiOjE2Njc5MjM1MTUuNjA0MTk0LCJuYmYiOjE2Njc5MjM1MTUuNjA0MTk1LCJleHAiOjQ4MjM1OTcxMTUuNTk2OTA5LCJzdWIiOiI2MDMxMzM1MSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.MFBTZLpU9Q6raVng61x8ilPsbGSNrS3Txys2Qluv10PaOnEtQF_emmpkwMev625lUl0ELAVrmstmwrAR3PkU_jTdpCAkyukVfGOD69KMUZE5QJw-UU6RVqs0aPyXzlIDMQVNWd1i7zryVw28VgsjbwtnMvE1S78Xc2tT-XetLJg_YjflJK1n0XOBpg_tQmDdMNLbPRwEr0RrSa8RFrY9PuRCUxNXLqk85ChQqGe65Bk0TcRpQb_kwF_iT7uaefToIdHIYUzs-IZ7smAFrkNeRzOcBsMPGZYzG5HjfRd5rlvMRyf87ZNnYxy_LcDTV6ZDQZCL6y79_V3RwAahWPbJhCJLWRLRUPcYlJqIVDG6nDnW4d-r6kC3cngvkMs44o0ZXAJ5n_9Ov37k6v3i8fMhsHwkrccofPnyCPzNKh0afSvsU4PxMppUBf35o4KlU33xqZzYA9L5aicE6V4-TtDWL-mxRyRyk1EgP4bUtxv_URmScPrD_hspWIK4jzOGIjRu1xvwAbPSx7NiF072IRCp1YJIxd--V0l5PkMnIT0ZMGtIkU-ieA9PBTDbx50vfZxzhQjE24JBYO55xSKzznE-dR6ltJi1wwirHS_799-gX6uaCQwUG7iYzDhwu71kA0TQYCQFCtvKIaoZQmPoVGdB_Xto6pWZhW_HbFtX3XJxBKE",
    baseUrls: BaseUrls.live,
    // apiKey:
    //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzNlNzI3MmI2YTE2MGZiMTA5MWQ5ZDNjYzQxOWFjMjJiZDI0NTExZmRiYjAwNTE0YjA4ODk0NmFmMGZhZWIxNzZlNjc1ZjU3ZDIwOWI4YjciLCJpYXQiOjE2Njc2NTQ0ODguODkxMjA1LCJuYmYiOjE2Njc2NTQ0ODguODkxMjA3LCJleHAiOjQ4MjMzMjgwODguODc4MTAzLCJzdWIiOiI2MDMxMzM1MSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.L6Xfz8cz-tarjH6-LP00IN-S7xCEY6Ex5tkgIpkbR6dV9Mg8bsN4iGtq5VaVwmnVk3tdEx8CwbgkrRdKotSgQvsws0mNaNU3AoQkl-wYulDMrSO1hv9M5oat5JPwdLwHFrWZyyAQI1GL2o-KUnA8cPe-K_waSAZVWBAnNG8J_I4JyFUvUnDjr_0RHl_uG0JdWpujUncPeIEVzcPf77PyQgEtcpWB16HGkOyEm_e09Gsi_2bl02PTFUOSMCUJiVkkxqUiKYHlDRkAVJ5PoPGZFQoUWIbClwoJO2MtbJ2NMhaTTfz1pb3sZa72yPQOIjGQOWZ1a43r5RqSCTlL0nJ3E-5d4Hj_YCxSwzOPJ2L8QvUJZFKlPtGJZNQ14AcIKDzlD8RoUK8C6KBw7TWDhoLdBDZRNSqxipOaiJGATjT9Fvo9SGam1DLgp9DfDbdXQ48h4q4BO_siRHSoqAGDwAWao3AuCNhI-8lpfFtph3APdBmf-4InqqI1TuDGipubyuH0ezqm4ma9GCkokxsHHrwa2w9bdt-vC1XALeKFWZPZIuEny4XYehrg8bLd31IerSiu5sAGZ3Lck1-5axtQ1ieuQuwDKdLm3OlbfQS-Aa6XY5SK3GSqKw5PFAuSJVV22_7nh01yYzJQW9GzAtiqsGy2h8dxyPHuEXW5UZhuG5S1W5Q",
    // baseUrls: BaseUrls.sandbox,
  );

  final path = await FilePicker.platform.getDirectoryPath();

  // ConverterResult response = await newclient.downloadResult(
  //   url.result,
  //   state.newFilename,
  //   state.newFileFormat,
  //   state.newFilePath,
  // );
  // if (response.exception != null) {
  //   print(response.exception);
  // }

  ConverterResult response = await newclient.downloadResult(
    dat.histList[index][0],
    dat.histList[index][1],
    dat.histList[index][2],
    path.toString(),
  );
  if (response.exception != null) {
    print(response.exception);
  }
}

void listRemove(List a, int index) {
  a.removeAt(index);
}

class _HistoryScreen extends State<HistScreen> {
  final _myBox = Hive.box('hist');

  histDataBase db = new histDataBase();

  @override
  void initState() {
    db.loadData();
    print('object');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurple[400],
          title: Text('история'),
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: 'конвертировать',
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.add_rounded),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ]),
      body: ListView.builder(
          itemCount: db.histList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(db.histList[index][1]),
                child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[400],
                     borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    db.histList[index][1]+'.'+db.histList[index][2],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          loadFile(index, db);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.download,
                                        color: Colors.white,
                                      )),
                                ])
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    db.histList.removeAt(index);
                                    db.updateData();
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ],
                    )

                    // ListTile(

                    //   title: Text(histList[index].SavedName),

                    // ),
                    ));
          }),
    );
  }
}

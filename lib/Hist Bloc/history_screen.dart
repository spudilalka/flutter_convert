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
    // apiKey:
    //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODE5ZmIwMWQxMGE2ZmY0OTNiNDVkMzhlMzc1NzcwZTA1M2RlNGYxMmVhODY5OWE0YjcyMWVhMzNlMTc5NTk4NTQ1MmM0NzQwNzZjMDg5OWYiLCJpYXQiOjE2NjY2Mjk5NzUuMTUzNjI3LCJuYmYiOjE2NjY2Mjk5NzUuMTUzNjI4LCJleHAiOjQ4MjIzMDM1NzUuMTQ4NjIxLCJzdWIiOiI2MDMxMzM1MSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.iC5mH0UVTyNmCRigNbegZp6i64nrYBvRvDymK8rEG2-UZErLAHThsWkys3sxdLai-UGoe_cAhsmGp_NfnK8hoDgmOnJ5xhMGSUDhIKUCfTuuMbnf2-NcuToTmgzc0Ps4D2FT3Bqi3wTOrvfXlZdo41GoyPZ1b2h9AhYFyCk6gw58I0iAdB4xL1PcFLNwYDVgrZqS2ueb4KNCCpVKlDkrz1lCR8k3LoITMszCi5hhxeN_yGP2R7wYqd3aMbh6v2rB5SCgtQQUxVsH7sXiWCykroZ3l0rAqt2k-U_WSs0b4FPeKVABoKdkCu6K94Ketg6ASj_qkALOUQYvnHaLG7gWY-b9EMcf8B0sOIjR7dN2vKoYV_Amfg1vG3PLbncN9PbVQ_LVNUp6KKaPFt0AwJgRgXOBvq9ytJwOoigdHjOhy1wUE40uSg1_JoBoHcWJQTQm8and_ecErHjzz3fl3C7796SAOe8n5lcbwXVITzFPdke7NNGYa_VthaQ_1nOr8xuDR8d-O-xQyP1fAu7G3JXGOIPYT3QQy9Hxj4KE_4tnLmzrrhJ00ArDYUHZ0PN6SubVsP3jakSpEKWNwljjmg2uRXkQxUj2nOLjnm1hFLWJu9RYQV1S4wwjJiUqBpoGzCgVcovJTD0TUDK76odi4oIoDTAzjaQoIaU7xl_ycDtDKsA",
    // baseUrls: BaseUrls.live,
    apiKey:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzNlNzI3MmI2YTE2MGZiMTA5MWQ5ZDNjYzQxOWFjMjJiZDI0NTExZmRiYjAwNTE0YjA4ODk0NmFmMGZhZWIxNzZlNjc1ZjU3ZDIwOWI4YjciLCJpYXQiOjE2Njc2NTQ0ODguODkxMjA1LCJuYmYiOjE2Njc2NTQ0ODguODkxMjA3LCJleHAiOjQ4MjMzMjgwODguODc4MTAzLCJzdWIiOiI2MDMxMzM1MSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.L6Xfz8cz-tarjH6-LP00IN-S7xCEY6Ex5tkgIpkbR6dV9Mg8bsN4iGtq5VaVwmnVk3tdEx8CwbgkrRdKotSgQvsws0mNaNU3AoQkl-wYulDMrSO1hv9M5oat5JPwdLwHFrWZyyAQI1GL2o-KUnA8cPe-K_waSAZVWBAnNG8J_I4JyFUvUnDjr_0RHl_uG0JdWpujUncPeIEVzcPf77PyQgEtcpWB16HGkOyEm_e09Gsi_2bl02PTFUOSMCUJiVkkxqUiKYHlDRkAVJ5PoPGZFQoUWIbClwoJO2MtbJ2NMhaTTfz1pb3sZa72yPQOIjGQOWZ1a43r5RqSCTlL0nJ3E-5d4Hj_YCxSwzOPJ2L8QvUJZFKlPtGJZNQ14AcIKDzlD8RoUK8C6KBw7TWDhoLdBDZRNSqxipOaiJGATjT9Fvo9SGam1DLgp9DfDbdXQ48h4q4BO_siRHSoqAGDwAWao3AuCNhI-8lpfFtph3APdBmf-4InqqI1TuDGipubyuH0ezqm4ma9GCkokxsHHrwa2w9bdt-vC1XALeKFWZPZIuEny4XYehrg8bLd31IerSiu5sAGZ3Lck1-5axtQ1ieuQuwDKdLm3OlbfQS-Aa6XY5SK3GSqKw5PFAuSJVV22_7nh01yYzJQW9GzAtiqsGy2h8dxyPHuEXW5UZhuG5S1W5Q",
    baseUrls: BaseUrls.sandbox,
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
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
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
                child: Card(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(db.histList[index][1]),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      loadFile(index, db);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.download,
                                    color: Colors.green,
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
                              color: Colors.grey,
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

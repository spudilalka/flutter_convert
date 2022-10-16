import 'package:flutter_convert/bloc/convert_event.dart';
import 'package:flutter_convert/bloc/convert_view.dart';
import 'package:flutter/material.dart';
import 'package:cloudconvert_client/cloudconvert_client.dart';

void main() async {
  String filepath = "C:\\Users\\79991\\Downloads\\a.txt";
  String keyy =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMTdhNmI3ZDYxMjdjYTlmYzJlNmRjNWUzNWJkMDlhYjdjOWY5MjJhMTc1MTU2MjcxYmFjNzg2ZDgzZjIwZTRhOTViY2FiYjJiNTg3OTdmYmMiLCJpYXQiOjE2NjU5NTgwNDEuNzY1OTIsIm5iZiI6MTY2NTk1ODA0MS43NjU5MjIsImV4cCI6NDgyMTYzMTY0MS43NjMxMDUsInN1YiI6IjYwMzEzMzUxIiwic2NvcGVzIjpbInVzZXIucmVhZCIsInVzZXIud3JpdGUiLCJ0YXNrLnJlYWQiLCJ0YXNrLndyaXRlIiwid2ViaG9vay5yZWFkIiwid2ViaG9vay53cml0ZSIsInByZXNldC5yZWFkIiwicHJlc2V0LndyaXRlIl19.RHLXajuQXxQf8kos6Qf70sH--QpRdK-6xeZybiQTpajiNknI_NsVGUGUyToX53AayyJiDDA4BQOan-oJCq6hIIfXJMpJLtBuPH1mlnfBd8o_5MToCu25S0hB1NagqjNoEqY0uX9XAbV13U4dbP-vUcbo-BPsXzteLrwAo2OL09vy0p5Vlgoiz4AI4q33SppMOy3JSZp95fdWqbfFYoIdNnQtbqUbX28jqMG8gOCaEUeWPywg0mVABcWu1vcUnSxA9_DUxtPo2gvVqpQRG-Q6VhqClCiCiWIyzCK6SPQEj0zjz1IL6l5Vs73gnqLTo4EBQCpkahTFMRDVenvfUEdXfcjaaF_TcIa_bcJ1dCMvzzWgY9qUrzroo8QVgpdt4OTi4QAylMi4aYdcQTodvbsepoo3hRrm8a23hBCB-S-4hA8wP-Sxh48yI6y02XH_I2MYGAkXvrcdgas2wIneNeanypwOKl3zfUqnmGq-2w31IsFt8oDf9gs7jjWQ0YfYaDQdsodIpCqsNOGc24NlrZyD3emV4q8cNkw-KY6kTLlLBRTnKVxS9mSdsPm3605sGdCcCjUHuGAHS8V4A-KotSqlT2ISC3dtABcMwTXhOdBidRj4a8Bfs5tTu7rLx3MMsC_xyt4VrcLbmNqVy0yAkDY9Sk7YEdE0oCZq1okThC8xPLc';
  Client newclient = Client(apiKey: keyy, baseUrls: BaseUrls.sandbox);
  ConverterResult token = await newclient.getSupportedFormats(filepath);
  if (token.exception != null) {
    print(token.exception);
  } else {
    print(token.result);
  }

  ConverterResult url = await newclient.postJob(filepath, "doc");
  if (url.exception != null) {
    print(url.exception);
    print("dopajfslkfjlskjffffffffffffff");
  } else {
    print(url.result);
  }
  ;

  ConverterResult response = await newclient.downloadResult(
      url.result, "huijopachlen", 'docx', "C:\\Users\\79991\\Downloads\\");
  if (response.exception != null) {
    print(response.exception);
  }

  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });
  // This widget is the root of your application.
  @override
  String filepath = '"C:\\Users\\79991\\Downloads\\api_task.pdf"';

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConvertPage(),
    );
  }
}

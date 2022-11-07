import 'package:flutter_convert/bloc/convert_view.dart';
import 'package:flutter/material.dart';
import 'package:cloudconvert_client/cloudconvert_client.dart';
import 'package:flutter_convert/Hist Bloc/history_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  var box = await Hive.openBox('hist');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ConvertPage(),
        '/hist': (context) => HistScreen()
      },
    );
  }
}

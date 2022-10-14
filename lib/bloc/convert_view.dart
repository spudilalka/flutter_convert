import 'dart:html';

import 'convert_bloc.dart';
import 'convert_event.dart';
import 'convert_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class ConvertPage extends StatefulWidget {
  const ConvertPage({Key? key}) : super(key: key);
  @override
  _ConvertPageState createState() => _ConvertPageState();
}

class ListItem {
  int value = 1;
  String format;
  String name;
  ListItem(this.value, this.format, this.name);
}

class _ConvertPageState extends State<ConvertPage> {
  List<ListItem> _dropdownItems = [
    ListItem(1, 'PNG', "First.png"),
    ListItem(2, "Word", "Second.doxc"),
    ListItem(3, "Txt", "Third txt"),
    ListItem(4, "Png", "Fourth.png")
  ];

  double progressBarValue = 0;

  void progressBarUpdate(progressBarValue) {
    progressBarValue += 100;
    print("pr bar update");
  }

  List<String> _forTxtAndWordItems = <String>[
    'PDF',
    'Word',
    'Txt',
  ];

  String dropdownValue = list.first;
  List<String> _forPNGItems = [
    'Jpeg',
    'BMP',
  ];

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        backgroundColor: Colors.grey[500],
        appBar: AppBar(
          title: Text('все фото'),
          centerTitle: true,
        ),
        body: BlocProvider(
            create: ((context) => ConvertBloc()),
            child: BlocBuilder<ConvertBloc, ConvertState>(
                builder: (context, state) {
              return Container(
                color: Colors.blueAccent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: Column(
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),

                        // DropdownButton(
                        //   value: 1,
                        //   items: _dropdownItems.map((ListItem item) {
                        //     return DropdownMenuItem<String>(
                        //       child: Text(item.name),
                        //       value: item.format,
                        //     );
                        //   },

                        //   ).toList(),
                        //   onChanged: (value) {
                        //     if (value == "1") {
                        //       PNGformat(format: state.format);
                        //       print('ERROR: 1');
                        //     } else if (value == "2") {
                        //       Wordformat(format: state.format);
                        //     } else if (value == "3") {
                        //       Txtformat(format: state.format);
                        //     } else {
                        //       print('ERROR: GG');
                        //     }
                        //   },
                        // ),

                        GestureDetector(
                          onTap: (() {
                            progressBarUpdate(progressBarValue);
                          }),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.deepPurple,
                          ),
                        ),

                        LinearProgressIndicator(
                          value: progressBarValue,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })));
  }
}

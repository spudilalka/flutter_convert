import 'convert_bloc.dart';
import 'convert_event.dart';
import 'convert_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void progressBarUpdate() {
    progressBarValue = progressBarValue;
    print("pr bar update");
  }

  List<String> _forTxtAndWordItems = ['PDF', 'Word', 'Txt'];
  List<String> _forPNGItems = [
    'Jpeg',
    'BMP',
  ];
  @override
  Widget build(BuildContext contex) {
    return BlocProvider(
        create: ((context) => ConvertBloc()),
        child:
            BlocBuilder<ConvertBloc, ConvertState>(builder: (context, state) {
          return Container(
            color: Colors.blueAccent,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: Column(
                  children: [
                    DropdownButton(
                      value: 1,
                      items: _dropdownItems.map((ListItem item) {
                        return DropdownMenuItem<int>(
                          child: Text(item.name),
                          value: item.value,
                        );
                      }).toList(),
                      onChanged: (format) {
                        if (format == "PNG") {
                          PNGformat(format: state.format);
                        } else if (format == "Word") {
                          Wordformat(format: state.format);
                        } else if (format == "Txt") {
                          Txtformat(format: state.format);
                        } else {
                          print('ERROR: GG');
                        }
                      },
                    ),
                    GestureDetector(
                      onTap: (() {
                        progressBarUpdate();
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
        }));
  }
}

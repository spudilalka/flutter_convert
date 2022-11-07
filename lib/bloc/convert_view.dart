import 'dart:ffi';

import 'package:hive/hive.dart';

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

void _menuOpen() {}

Widget iconz(String exeption) {
  if (exeption != '') {
    return IconButton(
      icon: Icon(
        Icons.accessible_outlined,
        color: Colors.red,
        size: 24.0,
      ),
      tooltip: exeption,
      onPressed: () {},
    );
  } else {
    return IconButton(
      icon: Icon(
        Icons.accessible_outlined,
        color: Colors.white,
        size: 24.0,
      ),
      tooltip: exeption,
      onPressed: () {},
    );
  }
}

class _ConvertPageState extends State<ConvertPage> {
  bool isActive = true;
  Color active = Colors.deepPurple;
  void check() {}

  String dropdownValue = '';

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        backgroundColor: Colors.grey[500],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('конвертация'),
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: 'история загрузок',
              alignment:Alignment.centerLeft,
              
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/hist');
              },
            ),
          ]
        ),
        body: BlocProvider(
            create: ((context) => ConvertBloc()),
            child: BlocBuilder<ConvertBloc, ConvertState>(
                builder: (context, state) {
              return Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                     
                                    GestureDetector(
                                      onTap: (() {
                                        context
                                            .read<ConvertBloc>()
                                            .add(PickFile());
                                      }),
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        color: Colors.deepPurple,
                                        child: Text(
                                          state.filename,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    iconz(state.exeption1),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 50,
                                      child: DropdownButton<String>(
                                        hint:
                                            const Text('выбор нового формата'),
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String? value) {
                                          print(state.newFileFormat);
                                          setState(() {
                                            dropdownValue = value!;
                                            context.read<ConvertBloc>().add(
                                                SetNewFileFormat(
                                                    NewFormat: value));

                                            print(
                                                '=====' + state.newFileFormat);
                                          });
                                        },
                                        items: state.availableFormats
                                            .map((e) =>
                                                DropdownMenuItem<String>(
                                                    value: e, child: Text(e)))
                                            .toList(),
                                      ),
                                    ),
                                    iconz(state.exeption2),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        context
                                            .read<ConvertBloc>()
                                            .add(PickNewFilePath());
                                      }),
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        color: Colors.deepPurple,
                                        child: Text(
                                          'выбор папки для сохранения ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    iconz(state.exeption3),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 50,
                                      child: TextField(
                                        onSubmitted: (text) {
                                          setState(() {
                                            context
                                                .read<ConvertBloc>()
                                                .add(PickName(newName: text));
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'введите новое имя файла',
                                        ),
                                      ),
                                    ),
                                    iconz(state.exeption4),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: (() {
                            context.read<ConvertBloc>().add(GetFile());
                          }),
                          child: Text(
                            'загрузить файл ' +
                                state.newFilename +
                                '.' +
                                state.newFileFormat,
                            style: TextStyle(
                              color: Colors.white,
                              backgroundColor: active,
                            ),
                          ),
                        ),
                        
                        
                      ],
                    ),
                  ),
                ),
              );
            })));
  }
}

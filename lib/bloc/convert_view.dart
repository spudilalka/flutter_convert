import 'dart:ffi';

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
          title: Text('все фото'),
          centerTitle: true,
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
                            GestureDetector(
                              onTap: (() {
                                context.read<ConvertBloc>().add(PickFile());
                              }),
                              child: Container(
                                width: 200,
                                height: 50,
                                color: Colors.deepPurple,
                                child: Text(
                                  state.filename,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              hint: const Text('выбор нового формата'),
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                print(state.newFileFormat);
                                setState(() {
                                  dropdownValue = value!;
                                  context
                                      .read<ConvertBloc>()
                                      .add(SetNewFileFormat(NewFormat: value));

                                  print('=====' + state.newFileFormat);
                                });
                              },
                              items: state.availableFormats
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e, child: Text(e)))
                                  .toList(),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 24.0,
                              ),
                              tooltip: state.exeption1,
                              onPressed: () {},
                            ),
                            iconz(state.exeption1),
                            iconz(state.exeption2),
                            iconz(state.exeption3),
                            iconz(state.exeption4),
                          ],
                        ),
                        GestureDetector(
                          onTap: (() {
                            context.read<ConvertBloc>().add(PickNewFilePath());
                          }),
                          child: Container(
                            width: 200,
                            height: 50,
                            color: Colors.deepPurple,
                            child: Text(
                              'выбор папки для сохранения ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        TextField(
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
                        TextButton(
                          onPressed: (() {
                            if (state.isAct != 'false') {                          
                              context.read<ConvertBloc>().add(GetFile());
                            } else {
                              print("ne GG");
                            }
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

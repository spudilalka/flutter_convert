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

Widget circularIndicator(double a, AnimationController controller) {
  if (a == 1) {
    return CircularProgressIndicator(
      value: controller.value,
      color: Colors.white,
      semanticsLabel: 'Circular progress indicator',
    );
  } else {
    return CircularProgressIndicator(
      value: controller.value,
      color: Colors.white.withOpacity(0),
      semanticsLabel: 'Circular progress indicator',
    );
  }
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
        color: Colors.deepPurple[200],
        size: 24.0,
      ),
      tooltip: exeption,
      onPressed: () {},
    );
  }
}

class _ConvertPageState extends State<ConvertPage>
    with TickerProviderStateMixin {
  bool isActive = true;
  Color active = Colors.deepPurple;
  BoxDecoration decor = BoxDecoration(
    color: Colors.deepPurple[400],
    borderRadius: BorderRadius.circular(10),
  );

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  bool loading = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String dropdownValue = '';

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[200],
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.deepPurple[400],
            title: Text('конвертация'),
            centerTitle: true,
            actions: [
              IconButton(
                tooltip: 'история загрузок',
                alignment: Alignment.centerLeft,
                icon: Icon(Icons.history),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/hist');
                },
              ),
            ]),
        body: BlocProvider(
            create: ((context) => ConvertBloc()),
            child: BlocBuilder<ConvertBloc, ConvertState>(
                builder: (context, state) {
              return Container(
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
                                        decoration: decor,
                                        width: 200,
                                        height: 70,
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
                                      height: 70,
                                      decoration: decor,
                                      padding: EdgeInsets.only(left: 10),
                                      child: DropdownButton<String>(
                                        hint: Text(state.newFileFormat,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            )),
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 0,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.white,
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
                                        height: 70,
                                        decoration: decor,
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
                                      height: 70,
                                      // margin: EdgeInsets.all(20),
                                      padding: EdgeInsets.only(top: 5),
                                      child: TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            context
                                                .read<ConvertBloc>()
                                                .add(PickName(newName: text));
                                          });
                                          TextStyle(color: Colors.white);
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            iconColor: Colors.white,
                                            hoverColor: Colors.deepPurple[400],
                                            fillColor: Colors.white,
                                            prefixIconColor: Colors.white,
                                            hintText: 'введите новое имя файла',
                                            hintStyle:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                    iconz(state.exeption4),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: (() {
                              setState(() {
                                context
                                    .read<ConvertBloc>()
                                    .add(SetLoad(a: true));
                              });
                             

                              setState(() {
                                context.read<ConvertBloc>().add(GetFile());
                          
                              });


                             
                            }),
                            child: Container(
                              width: 300,
                              height: 70,
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'загрузить файл ' +
                                    state.newFilename +
                                    '.' +
                                    state.newFileFormat,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        circularIndicator(state.load, controller),
                      ],
                    ),
                  ),
                ),
              );
            })));
  }
}

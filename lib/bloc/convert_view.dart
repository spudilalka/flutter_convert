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

  String dropdownValue = '';
  List<String> _forPNGItems = [
    'Jpeg',
    'BMP',
  ];

  @override
  Widget build(BuildContext contex) {
    
          return Scaffold(
              
              backgroundColor: Colors.grey[500],
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                title: Text('все фото'),
                centerTitle: true,

              ),
              body: 
              BlocProvider(

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
                            context
                                .read<ConvertBloc>()
                                .add(PickFile(filename: state.filename,filePath: state.filePath));
                          }),
                          child: Container(
                            width: 200,
                            height: 50,
                            color: Colors.deepPurple,
                            child:  Text(
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
                                value: state.format,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items:state.availableFormats.map((e) => DropdownMenuItem<String>( //!!!!!!я не понимаю, он не хочет принимать сюда лист, который прилетает через блок!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                                      value: e, child: Text(e)))
                                  .toList(),
                              ),
                              ],

                              ),
                              
                              
                  
                             
                              GestureDetector(
                                onTap: (() {
                                  progressBarUpdate(progressBarValue);
                                }),
                                child: Container(
                                  width: 200,
                                  height: 50,
                                  

                                  color: Colors.deepPurple,
                                  child: Text(
                              'куда кинуть полученный файл',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                              ),)
                                  
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

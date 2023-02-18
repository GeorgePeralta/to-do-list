import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      home: MyHome(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        // ignore: prefer_const_constructors
        colorScheme: ColorScheme.highContrastDark(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('To-Do List'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Form(
                key: _formKey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: taskController,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontSize: 32,
                        ),
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          hintText: 'Toque em "Enter" para criar sub-tarefas',
                          // ignore: prefer_const_constructors
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Task field it requiored';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_tasks[index]),
                  ),
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            debugPrint('Clique aqui');
            if (_formKey.currentState!.validate()) {
              setState(() {
                _tasks.add(taskController.text);
              });
              taskController.clear();
            }
          },
          backgroundColor: Colors.orange,
          hoverColor: Colors.orangeAccent,
          // ignore: prefer_const_constructors
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

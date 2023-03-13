import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskfy',
      home: const MyHome(),
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
  const MyHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _tasks = [];
  final List<bool> _checkBoxValues = [];
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
            const SizedBox(
              height: 30,
            ),
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
                          hintText: 'Clique aqui para criar sub-tarefas',
                          // ignore: prefer_const_constructors
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'O campo da tarefa é obrigatório';
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
                      title: Text(
                        _tasks[index],
                        style: TextStyle(
                          decoration: _checkBoxValues[index]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: Checkbox(
                        value: _checkBoxValues[index],
                        onChanged: (value) {
                          setState(() {
                            _checkBoxValues[index] = value!;
                          });
                        },
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _tasks.removeAt(index);
                                _checkBoxValues.removeAt(index);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
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
                _checkBoxValues.add(false);
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

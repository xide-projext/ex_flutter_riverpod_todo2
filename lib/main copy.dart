import 'package:flutter/material.dart';

// 1페이지에서 1개의 클래스에서 같은 상황이라서 어렵지않게 상태를 공유 할 수 있다.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo App',
        home: Scaffold(
            appBar: AppBar(title: Text('Todo List')),
            body: Column(children: [
              Text('Total status : ?'),
              SizedBox(
                height: 100.0,
                child: TodoListScreen(),
              ),
              SizedBox(
                height: 100.0,
                child: TodoListScreen(),
              )
            ])));
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todos = [];
  String todoStatus = "Status : ";
  TextEditingController controller = TextEditingController();

  void addTodo() {
    setState(() {
      todos.add(controller.text);
      controller.clear();
      todoStatus = "Status : ${todos.length}";
    });
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
      todoStatus = "Status : ${todos.length}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(todoStatus),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todos[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeTodo(index),
                ),
              );
            },
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Add todo',
            suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed: addTodo,
            ),
          ),
        ),
      ],
    );
  }
}

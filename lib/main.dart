import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

// 1페이지에서 1개의 클래스에서 같은 상황이라서 어렵지않게 상태를 공유 할 수 있다.
void main() {
  runApp(MyApp());
}


/// Annotating a class by `@riverpod` defines a new shared state for your application,
/// accessible using the generated [counterProvider].
/// This class is both responsible for initializing the state (through the [build] method)
/// and exposing ways to modify it (cf [increment]).
@riverpod
class Counter extends _$Counter {
  /// Classes annotated by `@riverpod` **must** define a [build] function.
  /// This function is expected to return the initial state of your shared state.
  /// It is totally acceptable for this function to return a [Future] or [Stream] if you need to.
  /// You can also freely define parameters on this method.
  @override
  int build() => 0;

  void increment() => state++;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int totalTodos = 0;

  void updateTotalStatus(int count) {
    setState(() {
      totalTodos += count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo x 2 App',
        home: Scaffold(
          appBar: AppBar(title: Text('Todo x 2 List : with callback')),
          body: Column(
            children: [
              Text('Total status : $totalTodos'),
              SizedBox(
                height: 300.0,
                child: TodoListScreen(
                onStatusChanged: (count) => updateTotalStatus(count),
              )),
              SizedBox(
                height: 300.0,
                child: TodoListScreen(
                onStatusChanged: (count) => updateTotalStatus(count),
              )),
            ],
          ),
        ));
  }
}

class TodoListScreen extends StatefulWidget {
  final Function(int) onStatusChanged;

  TodoListScreen({super.key, required this.onStatusChanged});

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
    widget.onStatusChanged(todos.length);

  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
      todoStatus = "Status : ${todos.length}";
    });
    widget.onStatusChanged(todos.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("TODO"),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';

class MyHomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List with BLoC'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoInitialState) {
            return Center(
              child: Text('No todos yet.'),
            );
          } else if (state is TodoLoadedState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.todos[index].title),
                  leading: Checkbox(
                    value: state.todos[index].isCompleted,
                    onChanged: (value) {
                      todoBloc.add(ToggleTodoEvent(index));
                    },
                  ),
                );
              },
            );
          } else {
            return Container(); // Placeholder
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context, todoBloc);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, TodoBloc todoBloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todoBloc.add(AddTodoEvent(_controller.text));
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

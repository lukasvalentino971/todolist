import 'dart:async';
import 'package:bloc/bloc.dart';

class Todo {
  final String title;
  final bool isCompleted;

  Todo(this.title, this.isCompleted);
}

// Todo Event
abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;

  AddTodoEvent(this.title);
}

class ToggleTodoEvent extends TodoEvent {
  final int index;

  ToggleTodoEvent(this.index);
}

// Todo State
abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<Todo> todos;

  TodoLoadedState(this.todos);
}

// Todo BLoC
// Todo BLoC
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> todos = [];

  TodoBloc() : super(TodoInitialState()) {
    on<AddTodoEvent>((event, emit) {
      todos.add(Todo(event.title, false));
      emit(TodoLoadedState(List.from(todos)));
    });

    on<ToggleTodoEvent>((event, emit) {
      todos[event.index] = Todo(
        todos[event.index].title,
        !todos[event.index].isCompleted,
      );
      emit(TodoLoadedState(List.from(todos)));
    });
  }
}

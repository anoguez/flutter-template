import 'package:equatable/equatable.dart';
import 'package:flutter_template/domain/entities/todo.dart';

sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodosEvent {
  const LoadTodos();
}

class ToggleTodoRequested extends TodosEvent {
  final Todo todo;

  const ToggleTodoRequested(this.todo);

  @override
  List<Object?> get props => [todo];
}

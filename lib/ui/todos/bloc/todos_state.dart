import 'package:equatable/equatable.dart';
import 'package:flutter_template/domain/entities/todo.dart';

sealed class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object?> get props => [];
}

class TodosInitial extends TodosState {
  const TodosInitial();
}

class TodosLoading extends TodosState {
  const TodosLoading();
}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  const TodosLoaded(this.todos);

  @override
  List<Object?> get props => [todos];
}

class TodosError extends TodosState {
  final String message;

  const TodosError(this.message);

  @override
  List<Object?> get props => [message];
}

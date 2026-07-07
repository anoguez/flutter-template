import 'package:flutter_template/core/usecase/usecase.dart';
import 'package:flutter_template/core/utils/typedef.dart';
import 'package:flutter_template/domain/entities/todo.dart';
import 'package:flutter_template/domain/repositories/todo_repository.dart';

class ToggleTodo extends UsecaseWithParams<Todo, Todo> {
  final TodoRepository _repository;

  const ToggleTodo(this._repository);

  @override
  ResultFuture<Todo> call(Todo params) => _repository.toggleTodo(params);
}

import 'package:flutter_template/core/usecase/usecase.dart';
import 'package:flutter_template/core/utils/typedef.dart';
import 'package:flutter_template/domain/entities/todo.dart';
import 'package:flutter_template/domain/repositories/todo_repository.dart';

class GetTodos extends UsecaseWithoutParams<List<Todo>> {
  final TodoRepository _repository;

  const GetTodos(this._repository);

  @override
  ResultFuture<List<Todo>> call() => _repository.getTodos();
}

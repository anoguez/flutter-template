import 'package:flutter_template/core/utils/typedef.dart';
import 'package:flutter_template/domain/entities/todo.dart';

abstract class TodoRepository {
  ResultFuture<List<Todo>> getTodos();

  ResultFuture<Todo> toggleTodo(Todo todo);
}

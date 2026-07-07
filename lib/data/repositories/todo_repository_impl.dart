import 'package:fpdart/fpdart.dart';
import 'package:flutter_template/core/errors/exceptions.dart';
import 'package:flutter_template/core/errors/failure.dart';
import 'package:flutter_template/core/utils/typedef.dart';
import 'package:flutter_template/data/services/todo_service.dart';
import 'package:flutter_template/domain/entities/todo.dart';
import 'package:flutter_template/domain/repositories/todo_repository.dart';
import 'package:logging/logging.dart';

class TodoRepositoryImpl implements TodoRepository {
  static final _log = Logger('TodoRepositoryImpl');

  final TodoService _service;

  TodoRepositoryImpl(this._service);

  @override
  ResultFuture<List<Todo>> getTodos() async {
    try {
      final todos = await _service.getTodos();
      return Right(todos);
    } on APIException catch (e) {
      _log.warning('Failed to load todos', e);
      return Left(APIFailure.fromException(e));
    } catch (e) {
      _log.severe('Unexpected error loading todos', e);
      return Left(UnknownFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Todo> toggleTodo(Todo todo) async {
    try {
      final updated = await _service.toggleTodo(
        todo.id,
        todo.title,
        todo.isCompleted,
      );
      return Right(updated);
    } on APIException catch (e) {
      _log.warning('Failed to toggle todo ${todo.id}', e);
      return Left(APIFailure.fromException(e));
    } catch (e) {
      _log.severe('Unexpected error toggling todo ${todo.id}', e);
      return Left(UnknownFailure.fromException(e));
    }
  }
}

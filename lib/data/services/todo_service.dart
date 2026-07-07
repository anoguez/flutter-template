import 'package:dio/dio.dart';
import 'package:flutter_template/core/errors/exceptions.dart';
import 'package:flutter_template/core/services/dio_service.dart';
import 'package:flutter_template/data/models/todo_model.dart';

/// Talks to a remote API and only ever throws [APIException].
///
/// This is the layer to swap out per-project: point [dioService] at your
/// real backend (see [TodoRepositoryImpl] for how failures flow upward).
abstract class TodoService {
  Future<List<TodoModel>> getTodos();

  Future<TodoModel> toggleTodo(String id, String title, bool isCompleted);
}

class TodoServiceImpl implements TodoService {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  final Dio _dio;

  TodoServiceImpl({Dio? dio}) : _dio = dio ?? dioService(baseUrl: _baseUrl);

  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      final response = await _dio.get('/todos', queryParameters: {'_limit': 20});
      return (response.data as List)
          .map(
            (item) => TodoModel.fromMap({
              'id': item['id'].toString(),
              'title': item['title'],
              'isCompleted': item['completed'],
            }),
          )
          .toList();
    } on DioException catch (e) {
      throw APIException(
        message: e.message ?? 'Failed to load todos',
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<TodoModel> toggleTodo(String id, String title, bool isCompleted) async {
    try {
      await _dio.patch('/todos/$id', data: {'completed': !isCompleted});
      return TodoModel.fromMap({
        'id': id,
        'title': title,
        'isCompleted': !isCompleted,
      });
    } on DioException catch (e) {
      throw APIException(
        message: e.message ?? 'Failed to update todo',
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}

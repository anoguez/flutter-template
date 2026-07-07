import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/core/services/locale_service.dart';
import 'package:flutter_template/data/repositories/todo_repository_impl.dart';
import 'package:flutter_template/data/services/todo_service.dart';
import 'package:flutter_template/domain/repositories/todo_repository.dart';
import 'package:flutter_template/domain/usecases/get_todos.dart';
import 'package:flutter_template/domain/usecases/toggle_todo.dart';
import 'package:flutter_template/ui/todos/bloc/todos_bloc.dart';

final sl = GetIt.instance;

void registerSingletons() {
  GetIt.I.registerLazySingleton<SettingsService>(() => SettingsService());
  GetIt.I.registerLazySingleton<LocaleService>(() => LocaleService());

  // Example feature (lib/ui/todos): service -> repository -> usecases -> bloc.
  // Replace with your own features following the same layering.
  GetIt.I.registerLazySingleton<TodoService>(() => TodoServiceImpl());
  GetIt.I.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(GetIt.I()),
  );
  GetIt.I.registerLazySingleton(() => GetTodos(GetIt.I()));
  GetIt.I.registerLazySingleton(() => ToggleTodo(GetIt.I()));
  GetIt.I.registerFactory(
    () => TodosBloc(getTodos: GetIt.I(), toggleTodo: GetIt.I()),
  );
}

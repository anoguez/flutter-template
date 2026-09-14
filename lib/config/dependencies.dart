import "package:get_it/get_it.dart";
import "package:flutter_template/core/preferences/application_preferences.dart";
import 'package:flutter_template/data/repositories/todo_repository_impl.dart';
import 'package:flutter_template/data/services/todo_service.dart';
import 'package:flutter_template/domain/repositories/todo_repository.dart';
import 'package:flutter_template/ui/todos/bloc/todos_bloc.dart';

final sl = GetIt.instance;

void registerSingletons() {
  GetIt.I.registerLazySingleton<ApplicationPreferencesStore>(
    () => SharedPreferencesApplicationPreferencesStore(),
  );
  GetIt.I.registerLazySingleton<ApplicationPreferences>(
    () => ApplicationPreferences(GetIt.I()),
  );

  // Example feature (lib/ui/todos): service -> repository -> usecases -> bloc.
  // Replace with your own features following the same layering.
  GetIt.I.registerLazySingleton<TodoService>(() => TodoServiceImpl());
  GetIt.I.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(GetIt.I()),
  );
  GetIt.I.registerFactory(() => TodosBloc(repository: GetIt.I()));
}

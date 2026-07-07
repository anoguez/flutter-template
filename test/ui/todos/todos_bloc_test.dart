import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_template/core/errors/failure.dart';
import 'package:flutter_template/domain/entities/todo.dart';
import 'package:flutter_template/domain/repositories/todo_repository.dart';
import 'package:flutter_template/domain/usecases/get_todos.dart';
import 'package:flutter_template/domain/usecases/toggle_todo.dart';
import 'package:flutter_template/ui/todos/bloc/todos_bloc.dart';
import 'package:flutter_template/ui/todos/bloc/todos_event.dart';
import 'package:flutter_template/ui/todos/bloc/todos_state.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late _MockTodoRepository repository;
  late TodosBloc bloc;

  const todo = Todo(id: '1', title: 'Write tests', isCompleted: false);

  setUpAll(() {
    registerFallbackValue(todo);
  });

  setUp(() {
    repository = _MockTodoRepository();
    bloc = TodosBloc(
      getTodos: GetTodos(repository),
      toggleTodo: ToggleTodo(repository),
    );
  });

  tearDown(() => bloc.close());

  group('LoadTodos', () {
    blocTest<TodosBloc, TodosState>(
      'emits [TodosLoading, TodosLoaded] on success',
      setUp: () {
        when(() => repository.getTodos())
            .thenAnswer((_) async => const Right([todo]));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadTodos()),
      expect: () => [
        const TodosLoading(),
        const TodosLoaded([todo]),
      ],
    );

    blocTest<TodosBloc, TodosState>(
      'emits [TodosLoading, TodosError] on failure',
      setUp: () {
        when(() => repository.getTodos()).thenAnswer(
          (_) async =>
              const Left(APIFailure(message: 'boom', statusCode: 500)),
        );
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadTodos()),
      expect: () => [
        const TodosLoading(),
        const TodosError('API error: boom'),
      ],
    );
  });

  group('ToggleTodoRequested', () {
    blocTest<TodosBloc, TodosState>(
      'updates the toggled todo in place',
      setUp: () {
        when(() => repository.toggleTodo(todo)).thenAnswer(
          (_) async => const Right(
            Todo(id: '1', title: 'Write tests', isCompleted: true),
          ),
        );
      },
      build: () => bloc,
      seed: () => const TodosLoaded([todo]),
      act: (bloc) => bloc.add(const ToggleTodoRequested(todo)),
      expect: () => [
        const TodosLoaded([
          Todo(id: '1', title: 'Write tests', isCompleted: true),
        ]),
      ],
    );
  });
}

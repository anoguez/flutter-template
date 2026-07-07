import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/errors/failure_mapper.dart';
import 'package:flutter_template/domain/usecases/get_todos.dart';
import 'package:flutter_template/domain/usecases/toggle_todo.dart';
import 'package:flutter_template/ui/todos/bloc/todos_event.dart';
import 'package:flutter_template/ui/todos/bloc/todos_state.dart';

/// Example feature demonstrating the usecase -> repository -> Either
/// pattern wired end-to-end into a BLoC. See lib/domain and lib/data for
/// the layers this depends on.
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final GetTodos _getTodos;
  final ToggleTodo _toggleTodo;

  TodosBloc({
    required GetTodos getTodos,
    required ToggleTodo toggleTodo,
  })  : _getTodos = getTodos,
        _toggleTodo = toggleTodo,
        super(const TodosInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<ToggleTodoRequested>(_onToggleTodoRequested);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    emit(const TodosLoading());
    final result = await _getTodos();
    result.fold(
      (failure) => emit(TodosError(mapFailureToMessage(failure))),
      (todos) => emit(TodosLoaded(todos)),
    );
  }

  Future<void> _onToggleTodoRequested(
    ToggleTodoRequested event,
    Emitter<TodosState> emit,
  ) async {
    final currentState = state;
    if (currentState is! TodosLoaded) return;

    final result = await _toggleTodo(event.todo);
    result.fold(
      (failure) => emit(TodosError(mapFailureToMessage(failure))),
      (updated) => emit(
        TodosLoaded([
          for (final todo in currentState.todos)
            if (todo.id == updated.id) updated else todo,
        ]),
      ),
    );
  }
}

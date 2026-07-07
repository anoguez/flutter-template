import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/config/dependencies.dart';
import 'package:flutter_template/ui/todos/bloc/todos_bloc.dart';
import 'package:flutter_template/ui/todos/bloc/todos_event.dart';
import 'package:flutter_template/ui/todos/bloc/todos_state.dart';

/// Example feature screen. Shows how a screen consumes a BLoC that is
/// wired to a usecase/repository/service stack (see lib/domain, lib/data).
class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TodosBloc>()..add(const LoadTodos()),
      child: const _TodosView(),
    );
  }
}

class _TodosView extends StatelessWidget {
  const _TodosView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        return switch (state) {
          TodosInitial() || TodosLoading() =>
            const Center(child: CircularProgressIndicator()),
          TodosError(:final message) => Center(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(message, style: $styles.text.body),
              ),
            ),
          TodosLoaded(:final todos) => ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return CheckboxListTile(
                  title: Text(todo.title, style: $styles.text.body),
                  value: todo.isCompleted,
                  onChanged: (_) => context
                      .read<TodosBloc>()
                      .add(ToggleTodoRequested(todo)),
                );
              },
            ),
        };
      },
    );
  }
}

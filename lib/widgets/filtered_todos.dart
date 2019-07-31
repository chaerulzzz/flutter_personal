import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_personal/blocs/blocs.dart';
import 'package:flutter_personal/widgets/widgets.dart';
import 'package:flutter_personal/screens/screens.dart';
import 'package:flutter_personal/keys/flutter_todos_keys.dart';
import 'package:flutter_personal/keys/flutter_widget_keys.dart';

class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);

    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoading) {
          return LoadingIndicator(key: WidgetKeys.todosLoading);
        } else if (state is FilteredTodosLoaded) {
          final todos = state.filteredTodos;
          return ListView.builder(
            key: WidgetKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return TodoItem(
                key: WidgetKeys.todoItemWidgetKey,
                todo: todo,
                onDismissed: (direction) {
                  todosBloc.dispatch(DeleteTodo(todo));
                  /*Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                    key: WidgetKeys.snackbar,
                    todo: todo,
                    onUndo: () => todosBloc.dispatch(AddTodo(todo)),
                    localizations: localizations,
                  ));*/
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: todo.id);
                    }),
                  );
                  /*if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                      key: WidgetKeys.snackbar,
                      todo: todo,
                      onUndo: () => todosBloc.dispatch(AddTodo(todo)),
                      localizations: localizations,
                    ));
                  }**/
                },
                onCheckboxChanged: (_) {
                  todosBloc.dispatch(
                    UpdateTodo(todo.copyWith(isDone: !todo.isDone)),
                  );
                },
              );
            },
          );
        } else {
          return Container(key: FlutterTodosKeys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}

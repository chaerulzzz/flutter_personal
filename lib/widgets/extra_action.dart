import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_personal/blocs/todos/todos.dart';
import 'package:flutter_personal/repository/models/extra_action.dart';
import 'package:flutter_personal/keys/flutter_todos_keys.dart';
import 'package:flutter_personal/keys/flutter_widget_keys.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key key}) : super(key: WidgetKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoaded) {
          bool allComplete = (todosBloc.currentState as TodosLoaded)
              .todos
              .every((todo) => todo.isDone);
          return PopupMenuButton<ExtraAction>(
            key: FlutterTodosKeys.extraActionsPopupMenuButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  todosBloc.dispatch(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  todosBloc.dispatch(ToggleAllComplete());
                  break;
                case ExtraAction.toggleAllInComplete:
                  todosBloc.dispatch(ToggleAllIncomplete());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
                  PopupMenuItem<ExtraAction>(
                    key: WidgetKeys.toggleAll,
                    value: allComplete ? ExtraAction.toggleAllComplete : ExtraAction.toggleAllInComplete,
                    child: Text(
                      allComplete
                          ? 'Mark All incomplete'
                          : 'Mark All Complete',
                    ),
                  ),
                  PopupMenuItem<ExtraAction>(
                    key: WidgetKeys.clearCompleted,
                    value: ExtraAction.clearCompleted,
                    child: Text(
                      'Clear Completed',
                    ),
                  ),
                ],
          );
        }
        return Container(key: FlutterTodosKeys.extraActionsEmptyContainer);
      },
    );
  }
}

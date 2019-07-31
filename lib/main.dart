import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_personal/keys/flutter_widget_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_personal/repository/todo_repository.dart';
import 'package:flutter_personal/commons/localizations.dart';
import 'package:flutter_personal/commons/uuid.dart';
import 'package:flutter_personal/blocs/blocs.dart';
import 'package:flutter_personal/repository/models/todo.dart';
import 'package:flutter_personal/screens/screens.dart';
import 'package:flutter_personal/commons/routes.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    BlocProvider(
      builder: (context) {
        return TodosBloc(
          todosRepository: TodoRepository(),
        )..dispatch(LoadTodos());
      },
      child: TodosApp(),
    ),
  );
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      localizationsDelegates: [
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        MainRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                builder: (context) => TabBloc(),
              ),
              BlocProvider<FilteredTodosBloc>(
                builder: (context) => FilteredTodosBloc(todosBloc: todosBloc),
              ),
              BlocProvider<StatsBloc>(
                builder: (context) => StatsBloc(todosBloc: todosBloc),
              ),
            ],
            child: HomeScreen(),
          );
        },
        MainRoutes.addTodo: (context) {
          return AddEditScreen(
            key: WidgetKeys.addTodoScreen,
            onSave: (task, note) {
              todosBloc.dispatch(
                AddTodo(Todo(id: Uuid().generateV4(), task:task, note: note)),
              );
            },
            isEditing: false,
          );
        },
      },
    );
  }
}

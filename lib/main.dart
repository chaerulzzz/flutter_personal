import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_personal/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_personal/keys/flutter_widget_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_personal/repository/todo_repository.dart';
import 'package:flutter_personal/screens/splash_screen.dart';
import 'package:flutter_personal/commons/localizations.dart';
import 'package:flutter_personal/commons/uuid.dart';
import 'package:flutter_personal/blocs/blocs.dart';
import 'package:flutter_personal/repository/models/todo.dart';
import 'package:flutter_personal/repository/user_repository.dart';
import 'package:flutter_personal/screens/screens.dart';
import 'package:flutter_personal/commons/routes.dart';


void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TodosBloc> (builder: (context) 
            => TodosBloc(todosRepository: TodoRepository())..dispatch(LoadTodos())
        ),
        BlocProvider<AuthenticationBloc>(builder: (context) => AuthenticationBloc(userRepository: userRepository)..dispatch(AppStarted())),
      ],
      child: TodosApp(userRepository: userRepository),
    )
  );
}

class TodosApp extends StatelessWidget {
  final UserRepository repository;

    TodosApp({Key key, @required UserRepository userRepository}) : assert(userRepository != null),
      repository = userRepository, 
      super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      localizationsDelegates: [
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        MainRoutes.login: (context) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
                if (state is UnInitialized) {
                  return SplashScreen();
                }

                if (state is UnAuthenticated) {
                  return LoginScreen(userRepository: repository);
                }

                if (state is Authenticated) {
                 return BlocProvider(builder: (context) => MenuBloc(), child: MainScreen(name: state.displayName),);
               }
              return null;
            }
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_personal/blocs/blocs.dart';
import 'package:flutter_personal/screens/post/post_screen.dart';
import 'package:flutter_personal/screens/todos/todos_screen.dart';
import 'package:flutter_personal/repository/models/models.dart';
import 'package:flutter_personal/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String _setLocale() {
  initializeDateFormatting("in_ID");
  return DateFormat("EEEE d MMMM yyyy", "in_ID").format(DateTime.now());
}

class DrawerItem {
  MainDrawerTab title;
  StatelessWidget widget;

  DrawerItem(this.title, this.widget);
}

class MainScreen extends StatelessWidget {
  final String name;
  final String formattedDate = _setLocale();

  MainScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder<MenuBloc, MainDrawerTab>(
      builder: (context, activeMenu) {
        if (activeMenu == MainDrawerTab.home) {
          return HomeScreen(name: name);
        }

        if (activeMenu == MainDrawerTab.todos) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(builder: (context) => TabBloc()),
              BlocProvider<FilteredTodosBloc>(builder: (context) => FilteredTodosBloc(todosBloc: todosBloc)),
              BlocProvider<StatsBloc>(builder: (context) => StatsBloc(todosBloc: todosBloc)),
            ],
          child: TodoScreen(name: name)
          );
        }

        if (activeMenu == MainDrawerTab.post) {
          return PostScreen(name: name);
        }

        if (activeMenu == MainDrawerTab.logout) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedOut()); 
          return CircularProgressIndicator();
        }

        return null;
      },
    );
  }
}

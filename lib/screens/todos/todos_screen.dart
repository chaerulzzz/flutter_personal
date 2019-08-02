import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_personal/blocs/blocs.dart';
import 'package:flutter_personal/widgets/main_drawer.dart';
import 'package:flutter_personal/widgets/widgets.dart';
import 'package:flutter_personal/commons/localizations.dart';
import 'package:flutter_personal/repository/models/models.dart';
import 'package:flutter_personal/keys/flutter_widget_keys.dart';
import 'package:flutter_personal/commons/routes.dart';

class TodoScreen extends StatelessWidget {
  final String name;
  TodoScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: WidgetKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, MainRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: 'Add Todo',
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => tabBloc.dispatch(UpdateTab(tab)),
          ),
          drawer: BlocBuilder<MenuBloc, MainDrawerTab>(
            builder: (context, activeMenu) {
              return MainDrawer(
                userName: name,
                activeMenu: activeMenu,
                onMenuSelected: (menu) => menuBloc.dispatch(UpdateMenu(menu))
              );
            }
          ),
        );
      },
    );
  }
}

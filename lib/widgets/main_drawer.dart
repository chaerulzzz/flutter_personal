import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal/keys/flutter_widget_keys.dart';
import 'package:flutter_personal/repository/models/drawer_menu.dart';

class MainDrawer extends StatelessWidget {
  
  final String userName;
  final MainDrawerTab activeMenu;
  final Function(MainDrawerTab) onMenuSelected;

  MainDrawer({
    Key key,
    @required this.userName,
    @required this.activeMenu,
    @required this.onMenuSelected
  }) : super(key: key ?? WidgetKeys.drawerKey);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('User A'), 
            accountEmail: Text('$userName'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.blue : Colors.white,
              child: Text('F'),
            ),
          ),
          Expanded(
            child: Container(
                child: Column(
                  children: <Widget>[
                    ListTileTheme(
                      child: ListTile(
                          leading: Icon(Icons.list),
                          title: Text('Home'),
                          selected: activeMenu == MainDrawerTab.home,
                          onTap: () {
                            Navigator.of(context).pop();
                            onMenuSelected(MainDrawerTab.values[0]);
                          },
                      ),
                      selectedColor: Colors.lightBlueAccent,
                    ),
                    ListTileTheme(
                      child: ListTile(
                          leading: Icon(Icons.list),
                          title: Text('Todos'),
                          selected: activeMenu == MainDrawerTab.todos,
                          onTap: () {
                            Navigator.of(context).pop();
                            onMenuSelected(MainDrawerTab.values[1]);
                          },
                      ),
                      selectedColor: Colors.lightBlueAccent,
                    ),
                    ListTileTheme(
                      child: ListTile(
                          leading: Icon(Icons.list),
                          title: Text('Post'),
                          selected: activeMenu == MainDrawerTab.post,
                          onTap: () {
                            Navigator.of(context).pop();
                            onMenuSelected(MainDrawerTab.values[3]);
                          },
                      ),
                      selectedColor: Colors.lightBlueAccent,
                  )
                ],
              )
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTileTheme(
                      child: ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Logout'),
                          onTap: () {
                            Navigator.of(context).pop();
                            onMenuSelected(MainDrawerTab.values[2]);
                          },
                          selected: activeMenu == MainDrawerTab.logout,
                      ),
                      selectedColor: Colors.lightBlueAccent,
                    )
                  ],
                )
              ),
            ),
          )
        ],
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_personal/blocs/menu/menu.dart';
import 'package:flutter_personal/commons/localizations.dart';
import 'package:flutter_personal/repository/models/models.dart';
import 'package:flutter_personal/repository/api/services.dart';
import 'package:flutter_personal/widgets/main_drawer.dart';

class PostScreen extends StatelessWidget {
  final String name;

  PostScreen({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text(FlutterBlocLocalizations.of(context).appTitle)),
      body: FutureBuilder(
        future: PostRepository().getAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Post postData = snapshot.data[index];
                return Card(
                  child: Text(postData.title)
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } 

          return CircularProgressIndicator();
        },
      ),
      drawer: BlocBuilder<MenuBloc, MainDrawerTab>(
        builder: (context, activeMenu) {
          return MainDrawer(
            userName: name,
            activeMenu: activeMenu,
            onMenuSelected: (menu) => menuBloc.dispatch(UpdateMenu(menu))
          );
        },
      )
    );
  }
}
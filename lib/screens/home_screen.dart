import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_personal/blocs/blocs.dart';
import 'package:flutter_personal/widgets/main_drawer.dart';
import 'package:flutter_personal/repository/models/models.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String _setLocale() {
  initializeDateFormatting("in_ID");
  return DateFormat("EEEE d MMMM yyyy", "in_ID").format(DateTime.now());
}

class HomeScreen extends StatelessWidget {  
  final String name;
  final String formattedDate = _setLocale();
  HomeScreen({Key key, @required this.name}) : super(key: key);
  
@override
  Widget build(BuildContext context) {
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    return BlocBuilder<MenuBloc, MainDrawerTab>(
      builder: (context, activeMenu) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(child: Text('Selamat Datang $name !\n $formattedDate', textAlign: TextAlign.center, ),)
            ],
          ),
          drawer: MainDrawer(
            userName: name,
            activeMenu: activeMenu,
            onMenuSelected: (menu) => menuBloc.dispatch(UpdateMenu(menu)
            )
          ),
        );
      });
    
  }
}
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_personal/blocs/menu/menu_event.dart';
import 'package:flutter_personal/repository/models/models.dart';

class MenuBloc extends Bloc<MenuEvent, MainDrawerTab> {
  @override
  MainDrawerTab get initialState => MainDrawerTab.home;

  @override
  Stream<MainDrawerTab> mapEventToState(MenuEvent event) async* {
    if (event is UpdateMenu) {
      yield event.menu;
    }
  }
}

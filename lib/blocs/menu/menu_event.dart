import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_personal/repository/models/models.dart';

@immutable
abstract class MenuEvent extends Equatable {
  MenuEvent([List props = const []]) : super(props);
}

class UpdateMenu extends MenuEvent {
  final MainDrawerTab menu;

  UpdateMenu(this.menu) : super([menu]);

  @override
  String toString() => 'UpdateMenu { Menu: $menu }';
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_personal/blocs/blocs.dart';
import 'package:flutter_personal/screens/screens.dart';
import 'package:flutter_personal/keys/flutter_todos_keys.dart';
import 'package:flutter_personal/keys/flutter_widget_keys.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id})
      : super(key: key ?? WidgetKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (BuildContext context, TodosState state) {
        final todo = (state as TodosLoaded)
            .todos
            .firstWhere((todo) => todo.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Todo Details'),
          ),
          body: todo == null
            ? Container(key: FlutterTodosKeys.emptyDetailsContainer)
              : Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: '${todo.id}__heroTag',
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 16.0,
                              ),
                              child: Text(
                                todo.task,
                                key: WidgetKeys.detailsTodoItemTask,
                                style:
                                    Theme.of(context).textTheme.headline,
                              ),
                            ),
                          ),
                          Text(
                            todo.note,
                            key: WidgetKeys.detailsTodoItemNote,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_personal/repository/todo_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_personal/blocs/todos/todos.dart';
import 'package:flutter_personal/repository/models/todo.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository todosRepository;

  TodosBloc({@required this.todosRepository});

  @override
  TodosState get initialState => TodosLoading();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is ToggleAllComplete) {
      yield* _mapToggleAllToState(completeAll: true);
    } else if (event is ToggleAllIncomplete) {
      yield* _mapToggleAllToState(completeAll: false);
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final todos = await this.todosRepository.getAllTodos();
      yield TodosLoaded(todos);
    } catch (_) {
      yield TodosNotLoaded();
    }
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    if (currentState is TodosLoaded) {
      try {
        await todosRepository.insertTodo(event.todo);
        List<Todo> updatedTodos = await todosRepository.getAllTodos();
        yield TodosLoaded(updatedTodos);
      } catch(_) {
        print(_.toString());
      }
    }
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (currentState is TodosLoaded) {
      await todosRepository.updateTodo(event.updatedTodo);
      final List<Todo> updatedTodos = await todosRepository.getAllTodos();
      yield TodosLoaded(updatedTodos);
    }
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    if (currentState is TodosLoaded) {
      todosRepository.deleteTodoById(event.todo.id);
      final List<Todo> updatedTodos = await todosRepository.getAllTodos();
      yield TodosLoaded(updatedTodos);
    }
  }

  Stream<TodosState> _mapToggleAllToState({bool completeAll}) async* {
    if (currentState is TodosLoaded) {
      final List<Todo> updatedTodos = await todosRepository.getAllTodos();
      for (int i =0; i < updatedTodos.length; i++) {
        Todo todoDetail = updatedTodos[i];

        if (todoDetail.isDone == completeAll) {
          todoDetail.isDone = !completeAll;
          await todosRepository.updateTodo(todoDetail);
        }
      }
      
      final List<Todo> updatedTodos2 = await todosRepository.getAllTodos();
      yield TodosLoaded(updatedTodos2);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (currentState is TodosLoaded) {
      final List<Todo> updatedTodos = await todosRepository.getAllTodos();
      
      for (int i =0; i < updatedTodos.length; i++) {
        Todo todoDetail = updatedTodos[i];
        todoDetail.isDone = false;
        await todosRepository.updateTodo(todoDetail);
      }
      
      final List<Todo> updatedTodos2 = await todosRepository.getAllTodos();
      yield TodosLoaded(updatedTodos2);
    }
  }
}

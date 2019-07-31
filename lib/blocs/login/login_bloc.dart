import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_personal/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_personal/blocs/login/login.dart';
import 'package:flutter_personal/commons/validator.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _repository;

  LoginBloc({@required UserRepository userRepository}) : assert(userRepository != null), _repository = userRepository;
  
  @override
  LoginState get initialState => LoginState.empty();

@override
  Stream<LoginState> transform(Stream<LoginEvent> events, Stream<LoginState> Function(LoginEvent event) next,) {
    final observableStream = events as Observable<LoginEvent>;
    final nondebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });

    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300)); 

    return super.transform(nondebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithCredentialPressed) {
      yield* _mapLoginWithCredentialsPressedToState(email: event.email, password: event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  @override 
  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validator.isValidEmail(email)
    );
  }

  @override
  Stream<LoginState>  _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validator.isValidPassword(password),
    );
  }

  @override
  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _repository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
      print(_.toString());
    }
  }

  @override
  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email, String password
  }) async* {
    yield LoginState.loading();

    try {
      await _repository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
      print(_.toString());
    }
  }
}
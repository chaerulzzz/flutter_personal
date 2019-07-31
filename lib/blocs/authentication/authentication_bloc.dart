import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_personal/blocs/authentication/authentication.dart';
import 'package:flutter_personal/repository/user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository repository;

  AuthenticationBloc({@required UserRepository userRepository}) : assert(userRepository != null),
  repository = userRepository;

  @override
  AuthenticationState get initialState => UnInitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await repository.isSignedIn();

      if (isSignedIn) {
        final name = await repository.getUser();
        yield Authenticated(name);
      } else {
        yield UnAuthenticated();
      }
    } catch (_) {
      print(_.toString());
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await repository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield UnAuthenticated();
    repository.signOut();
  }
}
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]): super(props);
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'Email changed {email: $email}';
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'Password Changed{password: $password}';
}

class LoginWithGooglePressed extends LoginEvent {
  @override 
  String toString() => 'Login with Google Button';
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password}) : super([email, password]);

  @override
  String toString() => 'Submitted { email: $email, password: $password}';
}

class LoginWithCredentialPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialPressed({@required this.email, @required this.password}) : super([email, password]);

  @override
  String toString() => 'Login With Credential Pressed { email: $email, password: $password}';
}
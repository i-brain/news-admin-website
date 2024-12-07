part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LogoutSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LogoutFailure extends LoginState {
  final String message;

  const LogoutFailure(this.message);
  @override
  List<Object> get props => [message];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object> get props => [message];
}

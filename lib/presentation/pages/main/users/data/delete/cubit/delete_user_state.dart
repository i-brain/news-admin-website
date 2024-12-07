part of 'delete_user_cubit.dart';

sealed class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object> get props => [];
}

class DeleteUserInitial extends DeleteUserState {
  const DeleteUserInitial();
}

class DeleteUserLoading extends DeleteUserState {
  const DeleteUserLoading();
}

class DeleteUserSuccess extends DeleteUserState {
  @override
  List<Object> get props => [];
}

class DeleteUserFailure extends DeleteUserState {
  final String message;

  const DeleteUserFailure(this.message);

  @override
  List<Object> get props => [message];
}

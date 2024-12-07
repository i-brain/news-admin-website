part of 'update_user_cubit.dart';

sealed class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {
  const UpdateUserInitial();
}

class UpdateUserLoading extends UpdateUserState {
  const UpdateUserLoading();
}

class UpdateUserSuccess extends UpdateUserState {
  @override
  List<Object> get props => [];
}

class UpdateUserFailure extends UpdateUserState {
  final String message;

  const UpdateUserFailure(this.message);

  @override
  List<Object> get props => [message];
}

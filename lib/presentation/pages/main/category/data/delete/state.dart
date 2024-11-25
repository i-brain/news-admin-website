part of 'cubit.dart';

sealed class DeleteCategoryState extends Equatable {
  const DeleteCategoryState();

  @override
  List<Object> get props => [];
}

class DeleteCategoryInitial extends DeleteCategoryState {
  const DeleteCategoryInitial();
}

class DeleteCategoryLoading extends DeleteCategoryState {
  const DeleteCategoryLoading();
}

class DeleteCategorySuccess extends DeleteCategoryState {
  @override
  List<Object> get props => [];
}

class DeleteCategoryFailure extends DeleteCategoryState {
  final String message;

  const DeleteCategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

part of 'cubit.dart';

sealed class CreateCategoryState extends Equatable {
  const CreateCategoryState();

  @override
  List<Object> get props => [];
}

class CreateCategoryInitial extends CreateCategoryState {
  const CreateCategoryInitial();
}

class CreateCategoryLoading extends CreateCategoryState {
  const CreateCategoryLoading();
}

class CreateCategorySuccess extends CreateCategoryState {
  @override
  List<Object> get props => [];
}

class CreateCategoryFailure extends CreateCategoryState {
  final String message;

  const CreateCategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

part of 'cubit.dart';

sealed class EditCategoryState extends Equatable {
  const EditCategoryState();

  @override
  List<Object> get props => [];
}

class EditCategoryInitial extends EditCategoryState {
  const EditCategoryInitial();
}

class EditCategoryLoading extends EditCategoryState {
  const EditCategoryLoading();
}

class EditCategorySuccess extends EditCategoryState {
  @override
  List<Object> get props => [];
}

class EditCategoryFailure extends EditCategoryState {
  final String message;

  const EditCategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

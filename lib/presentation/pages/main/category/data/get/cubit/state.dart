part of 'cubit.dart';

sealed class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

class GetCategoryInitial extends GetCategoryState {
  const GetCategoryInitial();
}

class GetCategoryLoading extends GetCategoryState {
  const GetCategoryLoading();
}

class GetCategorySuccess extends GetCategoryState {
  final List<Category> categories;

  const GetCategorySuccess(this.categories);
  @override
  List<Object> get props => [categories];
}

class GetCategoryFailure extends GetCategoryState {
  final String message;

  const GetCategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

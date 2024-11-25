part of 'delete_news_cubit.dart';

sealed class DeleteNewsState extends Equatable {
  const DeleteNewsState();

  @override
  List<Object> get props => [];
}

class DeleteNewsInitial extends DeleteNewsState {
  const DeleteNewsInitial();
}

class DeleteNewsLoading extends DeleteNewsState {
  const DeleteNewsLoading();
}

class DeleteNewsSuccess extends DeleteNewsState {
  @override
  List<Object> get props => [];
}

class DeleteNewsFailure extends DeleteNewsState {
  final String message;

  const DeleteNewsFailure(this.message);

  @override
  List<Object> get props => [message];
}

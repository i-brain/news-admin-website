part of 'create_news_cubit.dart';

sealed class CreateNewsState extends Equatable {
  const CreateNewsState();

  @override
  List<Object> get props => [];
}

class CreateNewsInitial extends CreateNewsState {
  const CreateNewsInitial();
}

class CreateNewsLoading extends CreateNewsState {
  const CreateNewsLoading();
}

class CreateNewsSuccess extends CreateNewsState {
  @override
  List<Object> get props => [];
}

class CreateNewsFailure extends CreateNewsState {
  final String message;

  const CreateNewsFailure(this.message);

  @override
  List<Object> get props => [message];
}

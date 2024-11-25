part of 'edit_news_cubit.dart';

sealed class EditNewsState extends Equatable {
  const EditNewsState();

  @override
  List<Object> get props => [];
}

class EditNewsInitial extends EditNewsState {
  const EditNewsInitial();
}

class EditNewsLoading extends EditNewsState {
  const EditNewsLoading();
}

class EditNewsSuccess extends EditNewsState {
  @override
  List<Object> get props => [];
}

class EditNewsFailure extends EditNewsState {
  final String message;

  const EditNewsFailure(this.message);

  @override
  List<Object> get props => [message];
}

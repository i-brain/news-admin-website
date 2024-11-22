import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../core/constants/error_messages.dart';
import '../../../../../../../core/helper_functions.dart';
import '../response.dart';
import '../service.dart';

part 'get_news_state.dart';

class GetNewsCubit extends Cubit<GetNewsState> {
  GetNewsCubit(this.service) : super(const GetNewsInitial());

  final INewsService service;

  Future<void> get() async {
    if (state is! GetNewsSuccess) {
      emit(const GetNewsLoading());
    }

    try {
      final response = await service.getAll();

      if (response.success) {
        emit(GetNewsSuccess(response.data));
      } else {
        emit(GetNewsFailure(response.message!));
      }
    } on DioException catch (exception) {
      if (isServerException(exception)) {
        emit(const GetNewsFailure(ErrorMessages.server));
      } else if (exception.error is SocketException) {
        emit(const GetNewsFailure(ErrorMessages.internet));
      } else {
        emit(
          GetNewsFailure(exception.message ?? ErrorMessages.errorOccurred),
        );
      }
    } catch (_) {
      emit(const GetNewsFailure(ErrorMessages.errorOccurred));
    }
  }
}

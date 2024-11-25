import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/constants/error_messages.dart';
import '../../../../../../core/helper_functions.dart';
import '../service.dart';

part 'delete_news_state.dart';

class DeleteNewsCubit extends Cubit<DeleteNewsState> {
  DeleteNewsCubit(this.service) : super(const DeleteNewsInitial());

  final INewsService service;

  Future<void> delete(int id) async {
    emit(const DeleteNewsLoading());

    try {
      final response = await service.delete(id);

      if (response.success) {
        emit(DeleteNewsSuccess());
      } else {
        emit(DeleteNewsFailure(response.message!));
      }
    } on DioException catch (exception) {
      if (isServerException(exception)) {
        emit(const DeleteNewsFailure(ErrorMessages.server));
      } else if (exception.error is SocketException) {
        emit(const DeleteNewsFailure(ErrorMessages.internet));
      } else {
        emit(
          DeleteNewsFailure(exception.message ?? ErrorMessages.errorOccurred),
        );
      }
    } catch (_) {
      emit(const DeleteNewsFailure(ErrorMessages.errorOccurred));
    }
  }
}

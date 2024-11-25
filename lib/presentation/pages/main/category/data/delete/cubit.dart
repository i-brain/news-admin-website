import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/constants/error_messages.dart';
import '../../../../../../core/helper_functions.dart';
import '../service.dart';

part 'state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  DeleteCategoryCubit(this.service) : super(const DeleteCategoryInitial());

  final ICategoryService service;

  Future<void> delete(int id) async {
    emit(const DeleteCategoryLoading());

    try {
      final response = await service.delete(id);

      if (response.success) {
        emit(DeleteCategorySuccess());
      } else {
        emit(DeleteCategoryFailure(response.message!));
      }
    } on DioException catch (exception) {
      if (isServerException(exception)) {
        emit(const DeleteCategoryFailure(ErrorMessages.server));
      } else if (exception.error is SocketException) {
        emit(const DeleteCategoryFailure(ErrorMessages.internet));
      } else {
        emit(
          DeleteCategoryFailure(
              exception.message ?? ErrorMessages.errorOccurred),
        );
      }
    } catch (_) {
      emit(const DeleteCategoryFailure(ErrorMessages.errorOccurred));
    }
  }
}

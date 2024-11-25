import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/constants/error_messages.dart';
import '../../../../../../core/helper_functions.dart';
import '../create/request.dart';
import '../service.dart';

part 'state.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  EditCategoryCubit(this.service) : super(const EditCategoryInitial());

  final ICategoryService service;

  Future<void> edit(int id, CreateCategoryRequest request) async {
    emit(const EditCategoryLoading());

    try {
      final response = await service.edit(id, request);

      if (response.success) {
        emit(EditCategorySuccess());
      } else {
        emit(EditCategoryFailure(response.message!));
      }
    } on DioException catch (exception) {
      if (isServerException(exception)) {
        emit(
          const EditCategoryFailure(ErrorMessages.server),
        );
      } else if (exception.error is SocketException) {
        emit(
          const EditCategoryFailure(ErrorMessages.internet),
        );
      } else {
        emit(
          EditCategoryFailure(exception.message ?? ErrorMessages.errorOccurred),
        );
      }
    } catch (error) {
      emit(const EditCategoryFailure(ErrorMessages.errorOccurred));
    }
  }
}

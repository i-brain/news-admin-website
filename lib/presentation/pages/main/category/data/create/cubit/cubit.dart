import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../core/constants/error_messages.dart';
import '../../../../../../../core/helper_functions.dart';
import '../../service.dart';
import '../request.dart';

part 'state.dart';

class CreateCategoryCubit extends Cubit<CreateCategoryState> {
  CreateCategoryCubit(this.service) : super(const CreateCategoryInitial());

  final ICategoryService service;
  Future<void> create(CreateCategoryRequest request) async {
    emit(const CreateCategoryLoading());

    try {
      final response = await service.create(request);

      if (response.success) {
        emit(CreateCategorySuccess());
      } else {
        emit(CreateCategoryFailure(response.message!));
      }
    } on DioException catch (exception) {
      if (isServerException(exception)) {
        emit(
          const CreateCategoryFailure(ErrorMessages.server),
        );
      } else if (exception.error is SocketException) {
        emit(
          const CreateCategoryFailure(ErrorMessages.internet),
        );
      } else {
        emit(
          CreateCategoryFailure(
              exception.message ?? ErrorMessages.errorOccurred),
        );
      }
    } catch (error) {
      log('error');
      emit(const CreateCategoryFailure(ErrorMessages.errorOccurred));
    }
  }
}

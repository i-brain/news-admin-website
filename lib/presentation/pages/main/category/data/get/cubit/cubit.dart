import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../core/constants/error_messages.dart';
import '../../../../../../../core/helper_functions.dart';
import '../response.dart';
import '../../service.dart';

part 'state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  GetCategoryCubit(this.service) : super(const GetCategoryInitial());

  final ICategoryService service;

  Future<void> get() async {
    if (state is! GetCategorySuccess) {
      emit(const GetCategoryLoading());
    }

    try {
      final response = await service.getAll();

      if (response.success) {
        emit(GetCategorySuccess(response.data));
      } else {
        emit(GetCategoryFailure(response.message!));
      }
    } on DioException catch (exception) {
      if (isServerException(exception)) {
        emit(const GetCategoryFailure(ErrorMessages.server));
      } else if (exception.error is SocketException) {
        emit(const GetCategoryFailure(ErrorMessages.internet));
      } else {
        emit(
          GetCategoryFailure(exception.message ?? ErrorMessages.errorOccurred),
        );
      }
    } catch (error) {
      emit(const GetCategoryFailure(ErrorMessages.errorOccurred));
    }
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_admin/presentation/pages/main/news/data/create_news/request.dart';
import '../../../../../../core/constants/error_messages.dart';
import '../../../../../../core/helper_functions.dart';
import '../firebase_service.dart';
import '../service.dart';

part 'edit_news_state.dart';

class EditNewsCubit extends Cubit<EditNewsState> {
  EditNewsCubit(this.service, this.firebaseService)
      : super(const EditNewsInitial());

  final INewsService service;
  final FirebaseService firebaseService;
  Future<void> edit(
    int id,
    CreateNewsRequest request,
    Uint8List? imageData,
  ) async {
    emit(const EditNewsLoading());

    try {
      if (imageData != null) {
        final imageUrl =
            await firebaseService.uploadImage(imageData, request.title);
        request.setImageUrl(imageUrl!);
      }

      final response = await service.edit(id, request);

      if (response.success) {
        emit(EditNewsSuccess());
      } else {
        emit(EditNewsFailure(response.message!));
      }
    } on DioException catch (exception) {
      if (isServerException(exception)) {
        emit(
          const EditNewsFailure(ErrorMessages.server),
        );
      } else if (exception.error is SocketException) {
        emit(
          const EditNewsFailure(ErrorMessages.internet),
        );
      } else {
        emit(
          EditNewsFailure(exception.message ?? ErrorMessages.errorOccurred),
        );
      }
    } catch (error) {
      emit(const EditNewsFailure(ErrorMessages.errorOccurred));
    }
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_admin/presentation/pages/main/news/data/firebase_service.dart';
import '../../../../../../../core/constants/error_messages.dart';
import '../../../../../../../core/helper_functions.dart';
import '../../service.dart';
import '../request.dart';

part 'create_news_state.dart';

class CreateNewsCubit extends Cubit<CreateNewsState> {
  CreateNewsCubit(this.service, this.firebaseService)
      : super(const CreateNewsInitial());

  final INewsService service;
  final FirebaseService firebaseService;
  Future<void> create(CreateNewsRequest request, Uint8List imageData) async {
    emit(const CreateNewsLoading());

    try {
      final imageUrl =
          await firebaseService.uploadImage(imageData, request.title);
      request.setImageUrl(imageUrl!);
      print('add newss started---');
      final id = request.title;
      await firebaseService.addNews(id);
      print('add newss success---');
      final response = await service.create(request);

      if (response.success) {
        emit(CreateNewsSuccess());
      } else {
        emit(CreateNewsFailure(response.message!));
      }
    } on DioException catch (exception) {
      if (isServerException(exception)) {
        emit(
          const CreateNewsFailure(ErrorMessages.server),
        );
      } else if (exception.error is SocketException) {
        emit(
          const CreateNewsFailure(ErrorMessages.internet),
        );
      } else {
        emit(
          CreateNewsFailure(exception.message ?? ErrorMessages.errorOccurred),
        );
      }
    } catch (error) {
      print('error---');
      print(error.toString());
      emit(const CreateNewsFailure(ErrorMessages.errorOccurred));
    }
  }
}

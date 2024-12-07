import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:news_admin/presentation/pages/main/users/data/update/request.dart';
import '../../../../../../../core/constants/error_messages.dart';
import '../../service.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit(this.service) : super(const UpdateUserInitial());
  final IUserService service;
  Future<void> update(UpdateUserRequest request) async {
    emit(const UpdateUserLoading());

    try {
      await service.update(request);

      emit(UpdateUserSuccess());
    } on SocketException {
      emit(const UpdateUserFailure(ErrorMessages.internet));
    } on FirebaseException catch (error) {
      if (error.message != null) {
        emit(UpdateUserFailure(error.message!));
      } else {
        emit(const UpdateUserFailure(ErrorMessages.errorOccurred));
      }
    } catch (_) {
      emit(const UpdateUserFailure(ErrorMessages.errorOccurred));
    }
  }
}

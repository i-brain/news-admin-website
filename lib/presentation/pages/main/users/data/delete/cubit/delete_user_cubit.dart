import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../core/constants/error_messages.dart';
import '../../service.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit(this.service) : super(const DeleteUserInitial());
  final IUserService service;
  Future<void> delete(String id) async {
    emit(const DeleteUserLoading());

    try {
      await service.delete(id);

      emit(DeleteUserSuccess());
    } on SocketException {
      emit(const DeleteUserFailure(ErrorMessages.internet));
    } on FirebaseException catch (error) {
      if (error.message != null) {
        emit(DeleteUserFailure(error.message!));
      } else {
        emit(const DeleteUserFailure(ErrorMessages.errorOccurred));
      }
    } catch (_) {
      emit(const DeleteUserFailure(ErrorMessages.errorOccurred));
    }
  }
}

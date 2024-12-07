import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/constants/error_messages.dart';
import '../service.dart';
import '../request.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.service) : super(const LoginInitial());
  final IAuthService service;

  Future<void> login(LoginRequest request) async {
    emit(const LoginLoading());

    try {
      await service.login(request);

      emit(LoginSuccess());
    } on SocketException {
      emit(const LoginFailure(ErrorMessages.internet));
    } on FirebaseAuthException catch (error) {
      if (error.message != null) {
        emit(LoginFailure(error.message!));
      } else {
        emit(const LoginFailure(ErrorMessages.errorOccurred));
      }
    } catch (_) {
      emit(const LoginFailure(ErrorMessages.errorOccurred));
    }
  }

  Future<void> logout() async {
    try {
      await service.logout();
      emit(LogoutSuccess());
    } on FirebaseAuthException catch (error) {
      if (error.message != null) {
        emit(LogoutFailure(error.message!));
      } else {
        emit(const LogoutFailure(ErrorMessages.errorOccurred));
      }
    } catch (e) {
      emit(const LogoutFailure(ErrorMessages.errorOccurred));
    }
  }
}

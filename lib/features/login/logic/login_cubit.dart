import 'package:bloc/bloc.dart';
import 'package:gymsystem/core/helper/constants.dart';
import 'package:gymsystem/core/helper/shared_pref_helper.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/features/login/data/models/login_request_model.dart';
import 'package:gymsystem/features/login/data/repos/login_repo.dart';
import 'package:gymsystem/features/login/logic/login_state.dart';

// login_cubit.dart
class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  Future<void> login(String userName, String password) async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequestModel(username: userName.trim(), password: password),
    );
    if (isClosed) return;
    response.when(
      success: (data) {
        SharedPrefHelper.setSecuredString(
          SharedPrefKeys.refreshToken,
          data.refreshToken,
        );
        SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, data.token);
        emit(const LoginState.success());
      },
      failure: (error) =>
          emit(LoginState.failure(error.apiErrorModel.getAllErrorMessages())),
    );
  }
}

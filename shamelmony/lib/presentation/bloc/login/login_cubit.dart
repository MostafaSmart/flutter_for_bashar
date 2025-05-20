import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/util/input_validator.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

/// Cubit لتسجيل الدخول
@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final InputValidator inputValidator;

  LoginCubit({
    required this.loginUseCase,
    required this.inputValidator,
  }) : super(LoginInitialState());

  /// تسجيل الدخول
  Future<void> login({
    required String username,
    required String password,
    required String deviceIMEI,
    required String deviceName,
  }) async {
    // التحقق من صحة المدخلات
    final usernameError = inputValidator.validateUsername(username);
    if (usernameError != null) {
      emit(LoginErrorState(message: usernameError));
      return;
    }

    final passwordError = inputValidator.validatePassword(password);
    if (passwordError != null) {
      emit(LoginErrorState(message: passwordError));
      return;
    }

    final deviceIMEIError = inputValidator.validateDeviceIMEI(deviceIMEI);
    if (deviceIMEIError != null) {
      emit(LoginErrorState(message: deviceIMEIError));
      return;
    }

    final deviceNameError = inputValidator.validateDeviceName(deviceName);
    if (deviceNameError != null) {
      emit(LoginErrorState(message: deviceNameError));
      return;
    }

    emit(LoginLoadingState());

    final params = LoginParams(
      username: username,
      password: password,
      deviceIMEI: deviceIMEI,
      deviceName: deviceName,
    );

    final result = await loginUseCase(params);

    result.fold(
      (failure) => emit(LoginErrorState(message: failure.message)),
      (token) => emit(LoginSuccessState(token: token)),
    );
  }

  /// إعادة تعيين الحالة
  void reset() {
    emit(LoginInitialState());
  }
}

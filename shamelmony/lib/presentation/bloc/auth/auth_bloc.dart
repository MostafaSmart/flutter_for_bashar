import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/check_auth_status_usecase.dart';
import '../../../domain/usecases/get_current_user_usecase.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Bloc للمصادقة
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.checkAuthStatusUseCase,
    required this.getCurrentUserUseCase,
    required this.authRepository,
  }) : super(AuthLoadingState()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LogoutEvent>(_onLogout);
  }

  /// معالجة حدث التحقق من حالة المصادقة
  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    
    final isLoggedIn = await checkAuthStatusUseCase();
    
    if (isLoggedIn) {
      final userResult = await getCurrentUserUseCase();
      
      userResult.fold(
        (failure) => emit(AuthErrorState(message: failure.message)),
        (user) => emit(AuthAuthenticatedState(user: user)),
      );
    } else {
      emit(AuthUnauthenticatedState());
    }
  }

  /// معالجة حدث تسجيل الخروج
  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    
    await authRepository.logout();
    
    emit(AuthUnauthenticatedState());
  }
}

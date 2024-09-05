import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:api/services/auth/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(
        confirmPassword: event.confirmPassword,
        passwordsMatch: event.confirmPassword == state.password,
      ));
    });

    on<SignUpSubmitted>((event, emit) async {
      if (!state.passwordsMatch) {
        emit(state.copyWith(isFailure: true));
        return;
      }
      emit(state.copyWith(isSubmitting: true));
      try {
        await _authService.signUpWithEmailAndPassword(
          state.email,
          state.password,
        );
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      try {
        await _authService.signInWithEmailAndPassword(
          state.email,
          state.password,
        );
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });

    // Sign Out Event
    on<SignOutEvent>((event, emit) async {
      await _authService.signOut();
      emit(AuthState.initial()); // Reset to initial state after sign out
    });
  }
}

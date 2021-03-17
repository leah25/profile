import 'package:hooks_riverpod/hooks_riverpod.dart';

final signInSignUpProvider = StateNotifierProvider((ref) => SignInSignUpBloc());

class SignInSignUpBloc extends StateNotifier<SignInSignUpModel> {
  /// Sign in sign up page business logic
  SignInSignUpBloc([SignInSignUpModel state])
      : super(state ?? SignInSignUpModel(IsSigninOrSignup.signin));

  /// Toggle between sign in and sign up
  togglePage() {
    if (state.isSignInOrSignup == IsSigninOrSignup.signup) {
      state = SignInSignUpModel(IsSigninOrSignup.signin);
    } else {
      state = SignInSignUpModel(IsSigninOrSignup.signup);
    }
  }

  /// set page is sign up or sign in
  setPage(IsSigninOrSignup pageState) {
    state = SignInSignUpModel(pageState);
  }
}

class SignInSignUpModel {
  final IsSigninOrSignup isSignInOrSignup;
  SignInSignUpModel(this.isSignInOrSignup);
}

enum IsSigninOrSignup { signin, signup }

class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = "An unknown error occurred"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch(code){
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure('Please enter a strong password.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure('An account already exists for this email.');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure('This user has been disabled. Please contact support for help');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithEmailAndPasswordFailure {
  final String message;

  const LogInWithEmailAndPasswordFailure([this.message = "Log In failed."]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    print(code);
    switch(code) {
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure('Invalid password');
      case 'too-many-requests':
        return const LogInWithEmailAndPasswordFailure('Try again Later.');
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure('User not found.');
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure('This user has been disabled. Please contact support for help');
      default:
        return const LogInWithEmailAndPasswordFailure();
    }

  }
}
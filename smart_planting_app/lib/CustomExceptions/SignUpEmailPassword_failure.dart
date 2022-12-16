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

  const LogInWithEmailAndPasswordFailure([this.message = "LogIn failed."]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch(code) {
      case 'weak-password':
        return const LogInWithEmailAndPasswordFailure('Invalid password');
      default:
        return const LogInWithEmailAndPasswordFailure();
    }

  }
}
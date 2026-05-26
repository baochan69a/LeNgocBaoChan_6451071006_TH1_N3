abstract class AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;
  LoginSubmitted({required this.email, required this.password});
}

class SignUpSubmitted extends AuthEvent {
  final String name; // Có thể dùng để update profile sau này
  final String email;
  final String password;
  SignUpSubmitted({
    required this.name,
    required this.email,
    required this.password,
  });
}

class RegisterRequest {
  final String name;
  final String? email;
  final String phone;
  final String countryIso;
  final String password;
  final String passwordConfirmation;

  RegisterRequest({
    required this.name,
    required this.phone,
    this.email,
    this.countryIso = "EG",
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      if (email != null) 'email': email,
      'country_iso': countryIso,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }

  RegisterRequest copyWith({String? name, String? phone, String? email, String? countryIso, String? password, String? passwordConfirmation}) {
    return RegisterRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryIso: countryIso ?? this.countryIso,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }
}

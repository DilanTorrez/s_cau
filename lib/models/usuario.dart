class Usuario {
  String username;
  String password;
  int? id;

  Usuario({required this.username, required this.password, this.id});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      username: json['username'],
      password: json['password'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      if (id != null) 'id': id,
    };
  }
}

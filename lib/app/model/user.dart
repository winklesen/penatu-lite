import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int idUser;
  final String pemilik;
  final String username;
  final String password;
  final String nomorTelepon;
  final String email;

  User({
    required this.idUser,
    required this.pemilik,
    required this.username,
    required this.password,
    required this.nomorTelepon,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'],
      pemilik: json['pemilik'],
      username: json['username'],
      password: json['password'],
      nomorTelepon: json['nomor_telepon'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'pemilik': pemilik,
      'username': username,
      'password': password,
      'nomor_telepon': nomorTelepon,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [idUser];
}

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int idUser;
  final String nama_toko;
  final String nama_user;
  final String password;
  final String nomorTelepon;
  final String email;

  User({
    required this.idUser,
    required this.nama_toko,
    required this.nama_user,
    required this.password,
    required this.nomorTelepon,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'],
      nama_toko: json['nama_toko'],
      nama_user: json['nama_user'],
      password: json['password'],
      nomorTelepon: json['nomor_telepon'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'nama_toko': nama_toko,
      'nama_user': nama_user,
      'password': password,
      'nomor_telepon': nomorTelepon,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [idUser];
}

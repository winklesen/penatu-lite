import 'package:equatable/equatable.dart';

class Pesanan extends Equatable{
  final int idPesanan;
  final int idUser;
  final String namaPelanggan;
  final String nomorTeleponPelanggan;
  final DateTime tanggalPemesanan;
  final DateTime tanggalPengambilan;
  final String status;
  final String catatan;

  Pesanan({
    required this.idPesanan,
    required this.idUser,
    required this.namaPelanggan,
    required this.nomorTeleponPelanggan,
    required this.tanggalPemesanan,
    required this.tanggalPengambilan,
    required this.status,
    required this.catatan,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      idPesanan: json['id_pesanan'],
      idUser: json['id_user'],
      namaPelanggan: json['nama_pelanggan'],
      nomorTeleponPelanggan: json['nomor_telepon_pelanggan'],
      tanggalPemesanan: DateTime.parse(json['tanggal_pemesanan']),
      tanggalPengambilan: DateTime.parse(json['tanggal_pengambilan']),
      status: json['status'],
      catatan: json['catatan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pesanan': idPesanan,
      'id_user': idUser,
      'nama_pelanggan': namaPelanggan,
      'nomor_telepon_pelanggan': nomorTeleponPelanggan,
      'tanggal_pemesanan': tanggalPemesanan.toIso8601String(),
      'tanggal_pengambilan': tanggalPengambilan.toIso8601String(),
      'status': status,
      'catatan': catatan,
    };
  }

  @override
  List<Object?> get props => [idPesanan];
}

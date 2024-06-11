import 'package:equatable/equatable.dart';

class Pesanan extends Equatable {
  String? idPesanan;
  String? idUser;
  final String namaPelanggan;
  final String nomorTeleponPelanggan;
  final String tanggalPemesanan;
  final String tanggalPengembalian;
  final String status;
  final String catatan;

  Pesanan({
    this.idPesanan,
    this.idUser,
    required this.namaPelanggan,
    required this.nomorTeleponPelanggan,
    required this.tanggalPemesanan,
    required this.tanggalPengembalian,
    required this.status,
    required this.catatan,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      idPesanan: json['id_pesanan'] ?? '',
      idUser: json['id_user'] ?? '',
      namaPelanggan: json['nama_pelanggan'] ?? '',
      nomorTeleponPelanggan: json['nomer_telepon_pelanggan'] ?? '',
      tanggalPemesanan: json['tanggal_pemesanan'] ?? '',
      tanggalPengembalian: json['tanggal_pengembalian'] ?? '',
      status: json['status'] ?? '',
      catatan: json['catatan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id_pesanan': idPesanan,
      'id_user': idUser,
      'nama_pelanggan': namaPelanggan,
      'nomer_telepon_pelanggan': nomorTeleponPelanggan,
      'tanggal_pemesanan': tanggalPemesanan,
      'tanggal_pengembalian': tanggalPengembalian,
      'status': status,
      'catatan': catatan,
    };
  }

  @override
  List<Object?> get props => [idPesanan];
}

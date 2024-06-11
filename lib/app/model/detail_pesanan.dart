import 'package:equatable/equatable.dart';

class DetailPesanan extends Equatable {
  final String idDetailPesanan;
  String idPesanan;
  final String namaDetailPesanan;
  final double berat;
  final int jumlah;
  final double harga;
  final String tipeLayanan;

  DetailPesanan({
    required this.idDetailPesanan,
    required this.idPesanan,
    required this.namaDetailPesanan,
    required this.berat,
    required this.jumlah,
    required this.harga,
    required this.tipeLayanan,
  });

  factory DetailPesanan.fromJson(Map<String, dynamic> json) {
    return DetailPesanan(
      idDetailPesanan: json['id_detail_pesanan'] ?? '',
      idPesanan: json['id_pesanan'] ?? '',
      namaDetailPesanan: json['nama_detail_pesanan'] ?? '',
      berat: double.parse(json['berat'].toString()) ?? 0,
      jumlah: json['jumlah'] ?? 1,
      harga: double.parse(json['harga'].toString()) ?? 0,
      tipeLayanan: json['tipe_layanan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id_detail_pesanan': idDetailPesanan,
      'id_pesanan': idPesanan,
      'nama_detail_pesanan': namaDetailPesanan,
      'berat': berat,
      'jumlah': jumlah,
      'harga': harga,
      'tipe_layanan': tipeLayanan,
    };
  }

  @override
  List<Object?> get props => [idDetailPesanan];
}

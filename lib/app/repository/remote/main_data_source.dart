import 'package:penatu/app/model/detail_pesanan.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/app/model/user.dart';



/// This is interface for every app event
/// Especially get data from remote
abstract class MainDataSource {

  // Future<List<User>> getAllUser();
  // Future<List<Pesanan>> getAllPesanan();
  // Future<List<DetailPesanan>> getAllDetailPesanan();

  Future<User> getUserDetail(String idUser);
  Future<List<Pesanan>> getPesananByStatus(String status);
  Future<List<DetailPesanan>> getPesananDetail(String idPesanan);

  Future<void> pustUserData(String idUser, User user);
  Future<void> postPesanan(Pesanan pesanan);
  Future<void> putPesananStatus(String idPesanan,String status);
  Future<void> postDetailPesanan(DetailPesanan detailPesanan);


}

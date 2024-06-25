import 'package:penatu/app/model/detail_pesanan.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/app/model/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// MainDataSource (interface)
/// network calls / API related
/// just the abstract function
abstract class MainDataSource {
  // User
  Future<supabase.GoTrueClient> getAuth();

  Future<void> signOut();

  Future<supabase.AuthResponse> postUserSignIn(String email, String password);

  Future<supabase.AuthResponse> postUserSignUp(String email, String password);

  Future<void> pustUserData(String idUser, User user);

  Future<void> putUserData(
    String idUser,
    String namaToko,
    String namaUser,
    String telepon,
  );

  Future<supabase.GoTrueClient> postUserMagicLink(
    String email,
  );

  Future<String?> getUserSessionId();

  Future<User> getUserSessionData();

  Future<User> getUserDetail(String idUser);

  // Pesanan
  Future<List<Pesanan>> getPesananByStatus(String idUser, [String? status]);

  Future<List<DetailPesanan>> getPesananDetail(String idPesanan);

  // Future<Pesanan> getPesananById(String idPesanan);

  Future<void> postPesanan(Pesanan pesanan);

  Future<void> putPesananStatus(String idPesanan, String status);

  Future<void> postDetailPesanan(DetailPesanan detailPesanan);
}

import 'package:penatu/app/helper/api_helper.dart';
import 'package:penatu/app/helper/log_helper.dart';
import 'package:penatu/app/model/detail_pesanan.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/app/model/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:penatu/app/repository/remote/main_data_source.dart';

class MainRepository extends MainDataSource {
  final ApiHelper _apiHelper;

  MainRepository(this._apiHelper);

  @override
  Future<supabase.GoTrueClient> getAuth() async {
    return _apiHelper.getAuth();
  }

  @override
  Future<void> signOut() async {
    return _apiHelper.signOut();
  }

  @override
  Future<supabase.GoTrueClient> postUserMagicLink(String email) async {
    return _apiHelper.postUserMagicLink(email);
  }

  @override
  Future<supabase.AuthResponse> postUserSignIn(
      String email, String password) async {
    return _apiHelper.postUserLogin(email, password);
  }

  @override
  Future<supabase.AuthResponse> postUserSignUp(
      String email, String password) async {
    return _apiHelper.postUserRegister(email, password);
  }

  @override
  Future<void> putUserData(
    String idUser,
    String namaToko,
    String namaUser,
    String telepon,
  ) async {
    return _apiHelper.putUserData(idUser, namaToko, namaUser, telepon);
  }

  @override
  Future<String?> getUserSessionId() async {
    String? userSession = await _apiHelper.getSessionId();
    return userSession;
  }

  @override
  Future<User> getUserSessionData() async {
    User? userSession = await _apiHelper.getSessionData();
    return userSession;
  }

  @override
  Future<List<Pesanan>> getPesananByStatus(String idUser,
      [String? status = '']) async {
    status = '%${status}%';
    final response = await _apiHelper.getWhereDataById(
      ApiHelper.TABLE_PESANAN,
      'id_user',
      idUser,
      'status',
      status,
    );
    return response.map<Pesanan>((json) => Pesanan.fromJson(json)).toList();
  }

  // @override
  // Future<DetailPesanan> getPesananDetail(String idPesanan) async {
  //   final response = await _apiHelper.getJoinedData(
  //     ApiHelper.TABLE_PESANAN,
  //     ApiHelper.TABLE_PESANAN_DETAIL,
  //     'id_pesanan',
  //     'id_pesanan',
  //     'id_pesanan',
  //     idPesanan,
  //   );
  //   return response
  //       .map<DetailPesanan>((json) => DetailPesanan.fromJson(json))
  //       .toList();
  // }

  @override
  Future<List<DetailPesanan>> getPesananDetail(String idPesanan) async {
    final response = await _apiHelper.getDataById(
        ApiHelper.TABLE_PESANAN_DETAIL, 'id_pesanan', idPesanan);
    return response
        .map<DetailPesanan>((json) => DetailPesanan.fromJson(json))
        .toList();
  }

  @override
  Future<User> getUserDetail(String idUser) async {
    final response =
        await _apiHelper.getDataById(ApiHelper.TABLE_USER, 'id_user', idUser);
    return response.map<User>((json) => User.fromJson(json));
  }

  @override
  Future<void> postDetailPesanan(DetailPesanan detailPesanan) async {
    await _apiHelper.insertData(
        ApiHelper.TABLE_PESANAN_DETAIL, detailPesanan.toJson());
  }

  //  post first. if suceed then ya know
  @override
  Future<void> postPesanan(Pesanan pesanan) async {
    await _apiHelper.insertData(ApiHelper.TABLE_PESANAN, pesanan.toJson());
  }

  @override
  Future<void> putPesananStatus(String idPesanan, String status) async {
    await _apiHelper.updateData(
        ApiHelper.TABLE_PESANAN, 'id_pesanan', idPesanan, {'status': status});
  }

  @override
  Future<void> pustUserData(String idUser, User user) async {
    await _apiHelper.updateData(
        ApiHelper.TABLE_USER, 'id_user', idUser, user.toJson());
  }
}

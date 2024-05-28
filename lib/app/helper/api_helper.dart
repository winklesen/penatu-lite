import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:penatu/app/model/user.dart' as model;
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiHelper {
  // static const sessionKey = "SESSION_KEY";
  final SupabaseClient _client;

  static const TABLE_USER = "user";
  static const TABLE_PESANAN = "pesanan";
  static const TABLE_PESANAN_DETAIL = "pesanan_detail";

  ApiHelper(this._client);

  /// Private Constructor
  ApiHelper._getInstance(this._client);

  static Future<ApiHelper> getInstance(String url, String key) async {
    await Supabase.initialize(
      url: url,
      anonKey: key,
    );

    final SupabaseClient client = Supabase.instance.client;
    return new ApiHelper._getInstance(
      client,
    );
  }

  Future<AuthResponse> postUserLogin(String email, String password) async {
    return _client.auth.signInWithPassword(email: email, password: password);
    //   AuthException
  }

  Future<AuthResponse> postUserRegister(String email, String password) async {
    return _client.auth.signUp(email: email, password: password);
  }

  Future<GoTrueClient> postUserMagicLink(
    String email,
  ) async {
    await _client.auth.signInWithOtp(
      email: email,
      emailRedirectTo:
          kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback',
    );

    return _client.auth;
  }

  Future<void> putUserData(
    String idUser,
    String namaToko,
    String namaUser,
    String telepon,
  ) async {
    await _client.from(TABLE_USER).update({
      'nama_toko': namaToko,
      'nama_user': namaUser,
      'nomor_telepon': telepon,
    }).eq('id_user', idUser);
  }

  Future<GoTrueClient> getAuth() async {
    return _client.auth;
  }

  Future<String?> getSessionId() async {
    return _client.auth.currentUser?.id;
  }

  Future<model.User> getSessionData() async {
    String? userId = await _client.auth.currentUser?.id;
    var response =
        await _client.from(TABLE_USER).select().eq('id_user', userId!).single();
    return model.User.fromJson(response);
    ;
  }

  // Generic CRUD operations
  // Create
  Future<void> insertData(String table, Map<String, dynamic> data) async {
    final response = await _client.from(table).insert(data);
    if (response.error != null) {
      throw Exception('Failed to insert data: ${response.error!.message}');
    }
  }

  // Read - Get all records
  Future<dynamic> getAllData(String table) async {
    try {
      final response = await _client.from(table).select();
      return response;
    } catch (e, stackTrace) {
      throw Exception('Failed to get data: ${e.toString()}');
    }
  }

  Future<dynamic> getWhereData(
    String table,
    String columnName,
    dynamic columnValue,
  ) async {
    final response =
        await _client.from(table).select().eq(columnName, columnValue);
    // if (response.error != null) {
    //   throw Exception('Failed to get data with where clause: ${response.error!.message}');
    // }
    return response;
  }

  // Read - Get a single record by ID
  Future<dynamic> getDataById(String table, String idColumn, dynamic id) async {
    final response =
        await _client.from(table).select().eq(idColumn, id).single();
    // if (response.error != null) {
    //   throw Exception('Failed to get data: ${response.error!.message}');
    // }
    return response;
  }

  // Update
  Future<void> updateData(String table, String idColumn, dynamic id,
      Map<String, dynamic> data) async {
    final response = await _client.from(table).update(data).eq(idColumn, id);
    if (response.error != null) {
      throw Exception('Failed to update data: ${response.error!.message}');
    }
  }

  // Delete
  Future<void> deleteData(String table, String idColumn, dynamic id) async {
    final response = await _client.from(table).delete().eq(idColumn, id);
    if (response.error != null) {
      throw Exception('Failed to delete data: ${response.error!.message}');
    }
  }

  // Specific methods for your tables
  // Get last 30 orders
  Future<dynamic> getLast30Orders(String table, String col,
      [bool isAscending = false, int limit = 30]) async {
    final response = await _client
        .from(table)
        .select()
        .order(col, ascending: isAscending)
        .limit(limit);
    // if (response.error != null) {
    //   throw Exception('Failed to get orders: ${response.error!.message}');
    // }
    return response;
  }

  // Search by name
  Future<dynamic> searchByName(
      String table, String nameColumn, String query) async {
    final response =
        await _client.from(table).select().ilike(nameColumn, '%$query%');
    // if (response.error != null) {
    //   throw Exception('Failed to search data: ${response.error!.message}');
    // }
    return response;
  }

  // Get data with pagination
  Future<dynamic> getDataWithPagination(
      String table, int limit, int offset) async {
    final response =
        await _client.from(table).select().range(offset, offset + limit - 1);
    // if (response.error != null) {
    //   throw Exception('Failed to get data: ${response.error!.message}');
    // }
    return response;
  }

  // Complex queries with filters and sorting
  // Future<List<Map<String, dynamic>>> getFilteredAndSortedData(
  //   String table,
  //   Map<String, dynamic> filters,
  //   Map<String, bool> sorting,
  // ) async {
  // var query = _client.from(table).select();
  //
  // // Applying filters
  // filters.forEach((key, value) {
  //   if (value is String) {
  //     query = query.ilike(key, '%$value%');
  //   } else {
  //     query = query.eq(key, value);
  //   }
  // });
  //
  // // Applying sorting
  // sorting.forEach((key, ascending) {
  //   query = query.order(key, ascending: ascending);
  // });
  //
  // final response = await query;
  // if (response.error != null) {
  //   throw Exception('Failed to get data: ${response.error!.message}');
  // }
  // return List<Map<String, dynamic>>.from(response.data);
  // }

  // Join tables and filter by foreign key
  Future<dynamic> getJoinedData(
    String mainTable,
    String foreignTable,
    String mainTableColumn,
    String foreignTableColumn,
    String foreignKey,
    dynamic keyValue,
  ) async {
    final response = await _client
        .from(mainTable)
        .select('*, $foreignTable!inner(*)')
        .eq('$foreignTable.$foreignKey', keyValue);
    // if (response.error != null) {
    //   throw Exception('Failed to get joined data: ${response.error!.message}');
    // }
    return response;
  }

// Advanced join and filter operation
// Future<List<Map<String, dynamic>>> getAdvancedJoinData({
//   required String mainTable,
//   required List<String> foreignTables,
//   required Map<String, String> joinConditions,
//   required Map<String, dynamic> filters,
//   required Map<String, bool> sorting,
// }) async {
//   var query = _client.from(mainTable).select();
//
//   // Adding join conditions
//   foreignTables.forEach((foreignTable) {
//     query = query.select('$foreignTable!inner(*)');
//   });
//
//   joinConditions.forEach((mainColumn, foreignColumn) {
//     query = query.eq(mainColumn, foreignColumn);
//   });
//
//   // Applying filters
//   filters.forEach((key, value) {
//     if (value is String) {
//       query = query.ilike(key, '%$value%');
//     } else {
//       query = query.eq(key, value);
//     }
//   });
//
//   // Applying sorting
//   sorting.forEach((key, ascending) {
//     query = query.order(key, ascending: ascending);
//   });
//
//   final response = await query;
//   if (response.error != null) {
//     throw Exception(
//         'Failed to get advanced join data: ${response.error!.message}');
//   }
//   return List<Map<String, dynamic>>.from(response.data);
// }
}

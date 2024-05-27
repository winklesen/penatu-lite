import 'package:penatu/app/helper/pref_helper.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';

class LocalRepository extends LocalDataSource {
  final SharedPrefHelper _prefHelper;

  LocalRepository(this._prefHelper);

  @override
  Future<bool> getIsDarkTheme() async {
    return await _prefHelper.getValueDarkTheme();
  }

  @override
  Future<int> getKiloPrice() async {
    return await _prefHelper.getValueKiloPrice();
  }

  @override
  Future<void> setIsDarkTheme(bool value) async {
    await _prefHelper.setDarkTheme(value);
  }

  @override
  Future<void> setKiloPrice(int value) async {
    await _prefHelper.setKiloPrice(value);
  }
}

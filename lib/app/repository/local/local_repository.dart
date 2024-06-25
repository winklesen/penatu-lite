import 'package:penatu/app/helper/pref_helper.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';

/// LocalDataRepository
/// implement the data source contract
class LocalRepository extends LocalDataSource {
  final SharedPrefHelper _prefHelper;

  LocalRepository(this._prefHelper);

  @override
  Future<bool> getIsDarkTheme() async {
    return await _prefHelper.getValueDarkTheme();
  }

  @override
  Future<double> getKiloPrice() async {
    return await _prefHelper.getValueKiloPrice() ?? 0;
  }

  @override
  Future<void> setIsDarkTheme(bool value) async {
    await _prefHelper.setDarkTheme(value);
  }

  @override
  Future<void> setKiloPrice(double value) async {
    await _prefHelper.setKiloPrice(value);
  }
}

/// LocalDataSource (interface)
/// store local storage / db related
/// just the abstract function
abstract class LocalDataSource {
  Future<void> setKiloPrice(double value);

  Future<double> getKiloPrice();

  /// Style & Theme
  Future<void> setIsDarkTheme(bool value);

  Future<bool> getIsDarkTheme();
}

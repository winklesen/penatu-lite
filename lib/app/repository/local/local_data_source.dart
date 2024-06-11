/// This is interface for every app event
/// Especially get data from local db
abstract class LocalDataSource {
  Future<void> setKiloPrice(double value);

  Future<double> getKiloPrice();

  /// Style & Theme
  Future<void> setIsDarkTheme(bool value);

  Future<bool> getIsDarkTheme();
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/main_bloc_observer.dart';
import 'package:penatu/app/di/injection_container.dart' as di;
import 'package:penatu/launcher/penatu_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Inject Dependency
  await di.init();

  SystemChrome.setPreferredOrientations([
    /// Lock the orientation to portrait mode
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(MyApp()));
}

// X filter tanggal
// TODO modify pie card pesanan
// TODO modify pie chart

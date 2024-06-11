import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/main_bloc_observer.dart';
import 'package:penatu/app/di/injection_container.dart' as di;
import 'package:penatu/launcher/penatu_app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MainBlocObserver();
  await di.init();

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[

    /// lock the orientation
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

// TODO filter tanggal
// TODO modify pie chart
import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:core_package/core_package.dart';


import 'app.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MediaKit.ensureInitialized();
  await Hive.initFlutter();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      "${(await getApplicationDocumentsDirectory()).path}/hydrated_blocs",
    ),
  );
  await configureInjection("dev");

  runApp(const App());
}

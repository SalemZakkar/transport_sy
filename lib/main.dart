import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

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

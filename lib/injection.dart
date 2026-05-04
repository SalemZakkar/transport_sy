

import 'package:core_package/core_package.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(String env) async {
  await GetItInjectableX(getIt).init(environment: env);
}

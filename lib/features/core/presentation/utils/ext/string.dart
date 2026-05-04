import 'package:transport_sy/injection.dart';

// import '../file_manager.dart';

extension Util on String {
  String get addLeadingTimeZero {
    if (length == 1) {
      return '0$this';
    }
    return this;
  }

  // String? get getUrl {
  //   return getIt<FileManager>().getFile(name: this);
  // }
}

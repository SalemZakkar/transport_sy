import 'package:transport_sy/generated/translation/translations.dart';
import 'package:flutter/material.dart';

extension Translation on BuildContext {
  Translations get translation => Translations.of(this)!;
}

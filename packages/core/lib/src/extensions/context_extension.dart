import 'package:core/src/generated/l10n.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  SharedLocalizations get l10n => SharedLocalizations.of(this);
}

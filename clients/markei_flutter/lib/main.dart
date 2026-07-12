import 'package:flutter/material.dart';

import 'app/markei_app.dart';
import 'app/markei_composition.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final composition = await MarkeiComposition.appPrivate();
  runApp(MarkeiApp(composition: composition));
}

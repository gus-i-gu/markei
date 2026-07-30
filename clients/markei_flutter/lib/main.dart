import 'package:flutter/material.dart';

import 'app/build_provenance.dart';
import 'app/markei_app.dart';
import 'app/markei_composition.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final buildProvenance = BuildProvenance.current;
  final composition = await MarkeiComposition.appPrivate();
  runApp(MarkeiApp(composition: composition, buildProvenance: buildProvenance));
}

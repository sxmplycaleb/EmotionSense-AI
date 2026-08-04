import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void bootstrap(Widget application) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: application));
}

import 'package:emotionsense_mobile/app/routing/foundation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const FoundationScreen()),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});

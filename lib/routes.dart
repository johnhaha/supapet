import 'package:go_router/go_router.dart';
import 'package:supapet/view/index.dart';
import 'package:supapet/view/pet_detail_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Index(),
    ),
    GoRoute(
      path: '/pet/:petID',
      builder: (context, state) =>
          PetDetailPage(petID: state.pathParameters['petID']!),
    ),
  ],
);

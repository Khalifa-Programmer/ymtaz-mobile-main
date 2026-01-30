// import 'package:flutter/material.dart';
// import 'package:uni_links/uni_links.dart';
// import 'dart:async';
//
// import '../../../feature/law_guide/presentation/law_by_id_screen.dart';
// import '../../../yamtaz.dart';
// import '../../router/routes.dart';
//
// class DeepLinkHandler {
//   StreamSubscription? _sub;
//
//   void init() {
//     // initDeepLink();
//     // _sub = linkStream.listen((String? link) {
//     //   if (link != null) {
//     //     handleDeepLink(link);
//     //   }
//     // }, onError: (err) {
//     //   // Handle error
//     // });
//   }
//
//   // Future<void> initDeepLink() async {
//   //   try {
//   //     final initialLink = await getInitialLink();
//   //     if (initialLink != null) {
//   //       handleDeepLink(initialLink);
//   //     }
//   //   } on Exception {
//   //     // Handle exception
//   //   }
//   // }
//
//   void handleDeepLink(String link) {
//     final uri = Uri.parse(link);
//     if (uri.pathSegments.isNotEmpty) {
//       final pathSegment = uri.pathSegments[0];
//       final id = (uri.pathSegments.length > 1)
//           ? uri.pathSegments[1]
//           : uri.queryParameters['id'] ?? "1";
//
//       switch (pathSegment) {
//         case 'laws':
//           navigatorKey.currentState?.push(
//             MaterialPageRoute(builder: (context) => LawByIdScreen(id: id)),
//           );
//           break;
//         case 'books':
//           navigatorKey.currentState?.pushNamed(Routes.login, arguments: id);
//           break;
//         case 'judicial-guide':
//           navigatorKey.currentState?.pushNamed(Routes.login, arguments: id);
//           break;
//         case 'lawyer':
//           navigatorKey.currentState?.pushNamed(Routes.login, arguments: id);
//           break;
//         default:
//           navigatorKey.currentState?.pushNamed(Routes.login);
//       }
//     }
//   }
//
//   void dispose() {
//     _sub?.cancel();
//   }
// }

// import 'package:bma_app/core/controller/State/state.dart';
// import 'package:flutter/cupertino.dart';

// class AppRouter extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin{
//   @override
//   final GlobalKey<NavigatorState> navigatorKey;

//   final AppStateManager appStateManager;

//   AppRouter({@required this.appStateManager}) : navigatorKey = GlobalKey<NavigatorState>(){
//     // TODO: Add Listeners
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 7
//     return Navigator(
//       // 8
//       key: navigatorKey,
//       // TODO: Add onPopPage
//       // 9
//       // ignore: prefer_const_literals_to_create_immutables
//       pages: [
        
//       ],
//     );
//   }

//   // TODO: Add _handlePopPage

//   // 10
//   @override
//   Future<void> setNewRoutePath(configuration) async => null;
// }
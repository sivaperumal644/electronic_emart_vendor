import 'package:electronic_emart_vendor/components/material_display_connection_status_overlay_widget_dart.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/login/login.dart';
import 'package:electronic_emart_vendor/screens/nav_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state.dart';

main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: GREY_COLOR),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuthenticated = false;

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(uri: 'http://cezhop.herokuapp.com/graphql');

    var graphQlClient = GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink as Link,
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      graphQlClient,
    );

    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: ChangeNotifierProvider<AppState>(
          builder: (_) => AppState(),
          child: MaterialDisplayConnectionStatusOverlayWidget(
            child: MaterialApp(
              theme: ThemeData(fontFamily: 'Quicksand'),
              home: isAuthenticated ? NavigateScreens() : LoginScreen(),
            ),
          ),
        ),
      ),
    );
  }

  getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    setState(() {
      isAuthenticated = token != null;
    });
  }
}

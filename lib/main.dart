import 'package:flutter/material.dart';

import './models/auth.dart';

import './Screens/homeScreen.dart';
import './Screens/loginScreen.dart';

bool _isAuthenticated = false;
// final MainModel _model = MainModel();
final auth = new AuthService();

void main() async {
  _isAuthenticated = await auth.checkIfAuthenticated();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Map<String, dynamic> _profile;
  // bool _loading = false;

  // @override
  // initState() {
  //   super.initState();
  //   authService.profile.listen((state) => setState(() => _profile = state));
  //   authService.loading.listen((state) => setState(() => _loading = state));
  // }

  @override
  void initState() {
    super.initState();
    auth.checkIfAuthenticated().then((bool isAuthenticated) {
      _isAuthenticated = isAuthenticated;
    }).catchError((onError) {
      print('checkIfAuthenticated error: ${onError.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginScreen(),
          '/home': (BuildContext context) => HomeScreen(),
        },
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) {
                return _isAuthenticated ? HomeScreen() : LoginScreen();
              });
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeScreen());
          }
        },
        onUnknownRoute: (RouteSettings settings) {
          print('onUnknownRoute');
          return MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen());
        },
    );
  }
}



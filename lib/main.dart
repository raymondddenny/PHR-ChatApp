import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phr_skripsi_chat/provider/providers.dart';
import 'package:phr_skripsi_chat/services/services.dart';
import 'package:provider/provider.dart';

import 'bloc/blocs.dart';
import 'pages/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PageBloc(),
          ),
          BlocProvider(
            create: (context) => UserBloc(),
          ),
          BlocProvider(create: (context) => ThemeBloc())
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
              ChangeNotifierProvider(create: (_) => UserProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeState.themeData,
              home: Wrapper(),
            ),
          ),
        ),
      ),
    );
  }
}

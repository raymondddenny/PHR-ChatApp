import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phr_skripsi_chat/provider/providers.dart';
import 'package:phr_skripsi_chat/services/services.dart';
import 'package:provider/provider.dart';

import 'bloc/blocs.dart';
import 'pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
          builder: (context, themeState) =>
              ChangeNotifierProvider<ImageUploadProvider>(
            create: (context) => ImageUploadProvider(),
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

import 'package:example_flutter/container/auth/auth_view.dart';
import 'package:example_flutter/container/home/home_view.dart';
import 'package:example_flutter/container/main/main_view.dart';
import 'package:example_flutter/utils/screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> rootRouter = <String, WidgetBuilder>{
  Screen.MAIN: (context) => const MainScreen(),
  Screen.HOME: (context) => const HomeView(),
  Screen.AUTH: (context) => const AuthView(),
};

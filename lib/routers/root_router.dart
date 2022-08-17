import 'package:example_flutter/container/auth/auth_view.dart';
import 'package:example_flutter/container/home/home_view.dart';
import 'package:example_flutter/utils/screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> rootRouter = <String, WidgetBuilder>{
  HOME: (context) => const HomeView(),
  AUTH: (context) => const AuthView(),
};

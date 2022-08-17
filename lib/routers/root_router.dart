import 'package:example_flutter/container/home/home_view.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> rootRouter = <String, WidgetBuilder>{
  '/': (context) => const HomeView(),
  '/login': (context) => const HomeView(),
};

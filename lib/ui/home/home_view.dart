import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewPage();
}

class _HomeViewPage extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    S lang = S.of(context);
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Home")),
        body: Center(
          child: Text(lang.hello("Tú")),
        ));
  }
}

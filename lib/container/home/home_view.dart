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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    S lang = S.of(context);
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(height: height * 0.05),
          Text(
            lang.login,
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: height * 0.03),
          )
        ],
      ),
    ));
  }
}

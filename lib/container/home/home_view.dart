import 'package:example_flutter/utils/constant.dart';
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
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(image_auth), fit: BoxFit.cover)),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: height * 0.05),
            Text(
              lang.login,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: width * 0.05),
            )
          ],
        ),
      ),
    ));
  }
}

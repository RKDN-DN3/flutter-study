import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AuthViewPage();
}

class _AuthViewPage extends State<AuthView> {
  bool _passwordVisible = false;
  final TextEditingController _userPasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    S lang = S.of(context);

    return SafeArea(
        top: true,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(height: height * 0.05),
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: lang.account,
                  ),
                ),
                SizedBox(height: height * 0.05),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _userPasswordController,
                  obscureText:
                      !_passwordVisible, //This will obscure text dynamically
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: lang.password,
                    hintText: lang.please_input_you_password,
                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

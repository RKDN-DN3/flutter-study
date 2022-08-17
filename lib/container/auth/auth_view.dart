import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              children: [
                SizedBox(height: height * 0.05),
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: lang.account,
                    hintText: lang.please_input_you_email,
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 25,
                      maxWidth: width * 0.1,
                    ),
                    prefixIcon: Container(
                      margin: EdgeInsets.only(left: width * 0.02),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FaIcon(
                          FontAwesomeIcons.at,
                          size: width * 0.05,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.05),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _userPasswordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: lang.password,
                    hintText: lang.please_input_you_password,
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 25,
                      maxWidth: width * 0.1,
                    ),
                    prefixIcon: Container(
                      margin: EdgeInsets.only(left: width * 0.02),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FaIcon(
                          FontAwesomeIcons.lock,
                          size: width * 0.05,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
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

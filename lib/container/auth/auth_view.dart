import 'package:example_flutter/container/auth/auth_provider.dart';
import 'package:example_flutter/model/data/user.dart';
import 'package:example_flutter/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AuthViewPage();
}

class _AuthViewPage extends State<AuthView> {
  final TextEditingController _userPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isFocusEmail = false;
  bool _isFocusPassword = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _isFocusEmail = false;
    _isFocusPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authNotifier = Provider.of<AuthProvider>(context);
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
                Focus(
                  onFocusChange: (value) {
                    setState(() {
                      _isFocusEmail = value;
                    });
                  },
                  child: TextFormField(
                    onChanged: (text) => authNotifier.changeUsername(text),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: lang.account,
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 25,
                        maxWidth: width * 0.1,
                      ),
                      prefixIcon: Container(
                        margin: EdgeInsets.only(left: width * 0.02),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FaIcon(FontAwesomeIcons.at,
                              size: height * 0.025,
                              color: _isFocusEmail
                                  ? Theme.of(context).primaryColorDark
                                  : Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.05),
                Focus(
                    onFocusChange: (value) {
                      setState(() {
                        _isFocusPassword = value;
                      });
                    },
                    child: TextFormField(
                      onChanged: (text) => authNotifier.changePassword(text),
                      keyboardType: TextInputType.text,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: lang.password,
                        prefixIconConstraints: BoxConstraints(
                          maxHeight: 25,
                          maxWidth: width * 0.1,
                        ),
                        prefixIcon: Container(
                          margin: EdgeInsets.only(left: width * 0.02),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FaIcon(FontAwesomeIcons.lock,
                                size: height * 0.025,
                                color: _isFocusPassword
                                    ? Theme.of(context).primaryColorDark
                                    : Colors.grey),
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: _isFocusPassword
                                ? Theme.of(context).primaryColorDark
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      animationDuration: Duration.zero,
                      onPressed: onForgotPassword,
                      child: Text(lang.forgot_password),
                    )),
                MaterialButton(
                  minWidth: width * 0.4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.blue,
                  onPressed: authNotifier.login,
                  child: Text(lang.login,
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
              ],
            ),
          ),
        ));
  }
}

void onForgotPassword() {}

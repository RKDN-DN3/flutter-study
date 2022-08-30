import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Input extends StatelessWidget {
  final TextInputType? type;
  final Widget? child;
  final bool? obscureText;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final bool? isPassword;
  final Function(String)? onChange;
  final String? labelText;
  final bool isFocus;
  final Function()? onPressEye;

  const Input(
      {Key? key,
      this.type,
      this.child,
      this.obscureText,
      this.decoration,
      this.controller,
      this.isPassword,
      this.onChange,
      this.labelText,
      this.isFocus = false,
      this.onPressEye})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return TextFormField(
      onChanged: onChange,
      keyboardType: TextInputType.text,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
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
                color:
                    isFocus ? Theme.of(context).primaryColorDark : Colors.grey),
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isFocus ? Icons.visibility : Icons.visibility_off,
            color: isFocus ? Theme.of(context).primaryColorDark : Colors.grey,
          ),
          onPressed: onPressEye,
        ),
      ),
    );
  }
}

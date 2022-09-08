import 'package:flutter/material.dart';

class View extends StatefulWidget {
  final TextEditingController editingController;
  final Color? color;
  const View({Key? key, required this.editingController, this.color})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ViewPage();
}

class _ViewPage extends State<View> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.editingController,
      style: TextStyle(color: widget.color),
    );
  }
}

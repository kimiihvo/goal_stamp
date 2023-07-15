import 'package:flutter/material.dart';

class EditableText extends StatefulWidget {
  final String initialText;

  const EditableText({Key? key, required this.initialText}) : super(key: key);

  @override
  _EditableTextState createState() => _EditableTextState();
}

class _EditableTextState extends State<EditableText> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _controller.value.text.length,
          );
        });
      },
      child: Text(
        _controller.text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

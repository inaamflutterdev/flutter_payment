import 'package:flutter/material.dart';

class ReuseableTextField extends StatefulWidget {
  const ReuseableTextField({
    super.key,
    required this.title,
    required this.formkey,
    required this.controller,
    required this.hint,
    this.isNumber,
  });
  final String title, hint;
  final bool? isNumber;
  final TextEditingController controller;
  final Key formkey;

  @override
  State<ReuseableTextField> createState() => _ReuseableTextFieldState();
}

class _ReuseableTextFieldState extends State<ReuseableTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          widget.isNumber == null ? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
        label: Text(widget.title),
        hintText: widget.hint,
      ),
    );
  }
}

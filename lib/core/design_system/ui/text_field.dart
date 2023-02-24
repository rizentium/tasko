import 'package:flutter/material.dart';

class TaskoTextField extends StatefulWidget {
  final TextEditingController _controller;
  final ValueNotifier<bool> _isValid;
  final InputDecoration? _decoration;
  final int? maxLines;

  const TaskoTextField({
    super.key,
    required TextEditingController controller,
    required ValueNotifier<bool> validation,
    this.maxLines,
    InputDecoration? decoration,
  })  : _controller = controller,
        _decoration = decoration,
        _isValid = validation;

  @override
  State<TaskoTextField> createState() => _TaskoTextFieldState();
}

class _TaskoTextFieldState extends State<TaskoTextField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._controller,
      decoration: widget._decoration?.copyWith(
        errorText: _errorText,
      ),
      onChanged: _onChanged,
      maxLines: widget.maxLines,
    );
  }

  _onChanged(String value) {
    final isEmpty = widget._controller.text.isEmpty;

    setState(() {
      if (isEmpty) {
        _errorText = 'Cannot be empty';
        widget._isValid.value = false;
      } else {
        _errorText = null;
        widget._isValid.value = true;
      }
    });
  }
}

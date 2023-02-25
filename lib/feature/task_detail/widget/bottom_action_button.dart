import 'package:flutter/material.dart';

class BottomActionButton extends StatelessWidget {
  final void Function(bool hasStarted, bool hasFinished)? onPressed;
  final bool hasStarted;
  final bool hasFinished;

  const BottomActionButton({
    super.key,
    this.onPressed,
    required this.hasStarted,
    required this.hasFinished,
  });

  String get buttonLabel {
    if (hasFinished) {
      return 'Back to In Progress';
    }
    if (hasStarted) {
      return 'Done';
    }
    return 'Start';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: FilledButton(
        onPressed: () => onPressed?.call(hasStarted, hasFinished),
        child: Text(buttonLabel),
      ),
    );
  }
}

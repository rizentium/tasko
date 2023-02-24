import 'package:flutter/material.dart';

class AppBarClose extends AppBar {
  final BuildContext context;
  final List<Widget>? _actions;

  AppBarClose({
    required this.context,
    super.title,
    super.key,
    super.elevation = 0.0,
    super.foregroundColor = Colors.black,
    super.automaticallyImplyLeading = false,
    super.backgroundColor = Colors.transparent,
    List<Widget>? actions,
  }) : _actions = actions;

  @override
  List<Widget>? get actions => [
        ...?_actions,
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ];
}

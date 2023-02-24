import 'package:flutter/material.dart';

class AppBarClose extends AppBar {
  final BuildContext context;

  AppBarClose({
    required this.context,
    super.title,
    super.key,
    super.elevation = 0.0,
    super.foregroundColor = Colors.black,
    super.automaticallyImplyLeading = false,
    super.backgroundColor = Colors.transparent,
  });

  @override
  List<Widget>? get actions => [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ];
}

import 'package:flutter/material.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/core/extension/date_time.dart';

class HistoryDetail extends StatelessWidget {
  final DateTime? createdAt;
  const HistoryDetail({super.key, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'History',
          style: context.textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
        Text(
          'Created at \n${createdAt?.toReadableFormat() ?? 'Not defined yet'}',
          style: context.textTheme.bodySmall,
        )
      ],
    );
  }
}

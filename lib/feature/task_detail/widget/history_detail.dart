import 'package:flutter/material.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/core/extension/date_time.dart';

class HistoryDetail extends StatelessWidget {
  final DateTime? createdAt;
  final DateTime? startedAt;
  final DateTime? finishedAt;

  const HistoryDetail({
    super.key,
    this.createdAt,
    this.startedAt,
    this.finishedAt,
  });

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
        ),
        const SizedBox(height: 8),
        if (startedAt != null)
          Text(
            'Started at \n${startedAt?.toReadableFormat() ?? 'Not defined yet'}',
            style: context.textTheme.bodySmall,
          ),
        const SizedBox(height: 8),
        if (finishedAt != null)
          Text(
            'Finished at \n${finishedAt?.toReadableFormat() ?? 'Not defined yet'}',
            style: context.textTheme.bodySmall,
          ),
      ],
    );
  }
}

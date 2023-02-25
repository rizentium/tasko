import 'package:flutter/material.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:timeago/timeago.dart' as timeago;

class TaskItem extends StatelessWidget {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final void Function()? onTap;

  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.startedAt,
    this.finishedAt,
    this.margin,
    this.padding,
    this.decoration,
    this.onTap,
  });

  String get _message {
    if (finishedAt != null) {
      return "Finised ${timeago.format(finishedAt!)}";
    }
    if (startedAt != null) {
      return "Started ${timeago.format(startedAt!)}";
    }
    return "Created ${timeago.format(createdAt)}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 14.0,
          ),
      padding: padding ?? const EdgeInsets.all(8.0),
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black12.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              _message,
              style: context.textTheme.labelMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

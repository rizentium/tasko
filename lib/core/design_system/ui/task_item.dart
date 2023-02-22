import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class TaskItem extends StatelessWidget {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;

  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.margin,
    this.padding,
    this.decoration,
  });

  String get _getCreatedAt {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(id, style: Theme.of(context).textTheme.bodyLarge),
              Text(
                _getCreatedAt,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DurationDetail extends StatelessWidget {
  final String? durationWorking;
  final String? durationBlocked;
  final String? durationInProgress;
  final String? durationCompleted;

  const DurationDetail({
    super.key,
    this.durationWorking,
    this.durationBlocked,
    this.durationInProgress,
    this.durationCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (durationBlocked != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Backlog',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(' $durationBlocked'),
            ],
          ),
        if (durationInProgress != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'In Progress',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(' $durationInProgress'),
            ],
          ),
        if (durationCompleted != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text('$durationCompleted'),
            ],
          ),
        if (durationWorking != null)
          Column(
            children: [
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Working Time'),
                  Text(' $durationWorking'),
                ],
              ),
            ],
          )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasko/data/entities/task_tracker.dart';

class BottomActionButton extends StatelessWidget {
  final void Function(bool hasStarted, bool hasFinished)? onPressed;
  final void Function(TaskTrackerType type)? onTracking;
  final bool hasStarted;
  final bool hasFinished;
  final List<TaskTracker>? trackers;

  const BottomActionButton({
    super.key,
    this.onPressed,
    this.onTracking,
    required this.hasStarted,
    required this.hasFinished,
    this.trackers,
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

  Icon get buttonTrackingIcon {
    final lastTrackingType = trackers?.last;

    if (lastTrackingType?.type == TaskTrackerType.started) {
      return const Icon(Icons.pause);
    }
    return const Icon(Icons.play_arrow);
  }

  String get buttonTrackingLabel {
    final lastTrackingType = trackers?.last;

    if (lastTrackingType?.type == TaskTrackerType.started) {
      return 'Pause Working';
    }
    return 'Start Working';
  }

  buttonTrackingPressed() {
    final lastTrackingType = trackers?.last;
    TaskTrackerType trackerResponse = TaskTrackerType.started;

    if (lastTrackingType?.type == TaskTrackerType.started) {
      trackerResponse = TaskTrackerType.stopped;
    }

    onTracking?.call(trackerResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () => onPressed?.call(hasStarted, hasFinished),
              child: Text(buttonLabel),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => buttonTrackingPressed(),
              icon: buttonTrackingIcon,
              label: Text(buttonTrackingLabel),
            ),
          ),
        ],
      ),
    );
  }
}

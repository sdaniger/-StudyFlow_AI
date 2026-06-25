import 'package:flutter/material.dart';
import '../../domain/entities/small_step.dart';

class SmallStepTile extends StatelessWidget {
  final SmallStep step;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const SmallStepTile({
    super.key,
    required this.step,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: step.isCompleted,
              onChanged: (_) => onToggle(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              step.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    decoration: step.isCompleted ? TextDecoration.lineThrough : null,
                    color: step.isCompleted
                        ? Theme.of(context).textTheme.bodySmall?.color
                        : null,
                  ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            color: Theme.of(context).colorScheme.error,
          ),
        ],
      ),
    );
  }
}

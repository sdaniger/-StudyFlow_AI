import 'package:flutter/material.dart';
import '../../domain/entities/small_step.dart';

class SmallStepTile extends StatefulWidget {
  final SmallStep step;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final ValueChanged<String> onUpdate;
  final ValueChanged<String> onNotesUpdate;
  final int index;

  const SmallStepTile({
    super.key,
    required this.step,
    required this.onToggle,
    required this.onDelete,
    required this.onUpdate,
    this.onNotesUpdate = _noop,
    this.index = 0,
  });

  static void _noop(String _) {}

  @override
  State<SmallStepTile> createState() => _SmallStepTileState();
}

class _SmallStepTileState extends State<SmallStepTile> {
  bool _isEditing = false;
  bool _isNotesExpanded = false;
  late TextEditingController _editController;
  late FocusNode _focusNode;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.step.title);
    _notesController = TextEditingController(text: widget.step.notes ?? '');
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _editController.dispose();
    _notesController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SmallStepTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step.title != widget.step.title && !_isEditing) {
      _editController.text = widget.step.title;
    }
    if (oldWidget.step.notes != widget.step.notes && !_isNotesExpanded) {
      _notesController.text = widget.step.notes ?? '';
    }
  }

  void _startEditing() {
    setState(() => _isEditing = true);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  void _saveEdit() {
    final newTitle = _editController.text.trim();
    if (newTitle.isNotEmpty && newTitle != widget.step.title) {
      widget.onUpdate(newTitle);
    }
    setState(() => _isEditing = false);
  }

  void _cancelEdit() {
    _editController.text = widget.step.title;
    setState(() => _isEditing = false);
  }

  void _saveNotes() {
    final newNotes = _notesController.text.trim();
    if (newNotes != (widget.step.notes ?? '')) {
      widget.onNotesUpdate(newNotes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ReorderableDragStartListener(
                index: widget.index,
                child: const Icon(Icons.drag_handle, color: Colors.grey, size: 20),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: widget.step.isCompleted,
                  onChanged: (_) => widget.onToggle(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _isEditing
                    ? TextField(
                        controller: _editController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onSubmitted: (_) => _saveEdit(),
                      )
                    : GestureDetector(
                        onDoubleTap: _startEditing,
                        child: Text(
                          widget.step.title,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    decoration: widget.step.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: widget.step.isCompleted
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.color
                                        : null,
                                  ),
                        ),
                      ),
              ),
              if (_isEditing) ...[
                IconButton(
                  icon: const Icon(Icons.check, size: 18),
                  onPressed: _saveEdit,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: Colors.green,
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: _cancelEdit,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: Colors.grey,
                ),
              ] else ...[
                IconButton(
                  icon: Icon(
                    _isNotesExpanded ? Icons.expand_less : Icons.notes,
                    size: 16,
                  ),
                  onPressed: () {
                    if (_isNotesExpanded) _saveNotes();
                    setState(() => _isNotesExpanded = !_isNotesExpanded);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: widget.step.notes != null && widget.step.notes!.isNotEmpty
                      ? Colors.amber
                      : Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 16),
                  onPressed: _startEditing,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: widget.onDelete,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ],
          ),
          if (_isNotesExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 64, top: 4, bottom: 4, right: 8),
              child: TextField(
                controller: _notesController,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Add notes...',
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onChanged: (_) => _saveNotes(),
              ),
            ),
        ],
      ),
    );
  }
}

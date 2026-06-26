import 'package:flutter/material.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class ApiKeyTile extends StatefulWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final ValueChanged<String> onSaved;

  const ApiKeyTile({
    super.key,
    required this.label,
    required this.icon,
    this.initialValue,
    required this.onSaved,
  });

  @override
  State<ApiKeyTile> createState() => _ApiKeyTileState();
}

class _ApiKeyTileState extends State<ApiKeyTile> {
  late TextEditingController _controller;
  bool _obscured = true;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ApiKeyTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue && !_hasChanged) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  void _save() {
    final key = _controller.text.trim();
    widget.onSaved(key);
    setState(() => _hasChanged = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.settingsApiKeySaved)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListTile(
      leading: Icon(widget.icon, color: AppColors.primary),
      title: Text(widget.label),
      subtitle: TextField(
        controller: _controller,
        obscureText: _obscured,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(_obscured ? Icons.visibility_off : Icons.visibility, size: 18),
                onPressed: () => setState(() => _obscured = !_obscured),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        onChanged: (_) {
          if (!_hasChanged) setState(() => _hasChanged = true);
        },
      ),
      trailing: FilledButton.tonalIcon(
        onPressed: _hasChanged ? _save : null,
        icon: const Icon(Icons.check, size: 16),
        label: Text(l10n.settingsApiKeySave),
      ),
    );
  }
}

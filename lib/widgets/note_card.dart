import 'package:flutter/material.dart';
import 'package:notef_fschmatz/entity/note.dart';

import '../service/note_service.dart';
import 'dialog_store_note.dart';

class NoteCard extends StatefulWidget {
  @override
  State<NoteCard> createState() => _NoteCardState();

  final Note note;

  const NoteCard({Key? key, required this.note}) : super(key: key);
}

class _NoteCardState extends State<NoteCard> {
  final NoteService noteService = NoteService();

  Future<void> _pinAndUnpinNotification() async {
    if (widget.note.isPinned()) {
      noteService.dismissNotification(widget.note.id!);
    } else {
      noteService.createNotification(widget.note.id!, widget.note.title!, widget.note.text!);
    }

    noteService.changeState(widget.note);
  }

  _openDialogEdit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogStoreNote(note: widget.note);
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPinned = widget.note.isPinned();
    final Color iconColor = isPinned ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurfaceVariant;
    final Color iconBackground = isPinned ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest;
    final Color? tileBackgroundColor = isPinned ? theme.colorScheme.secondaryContainer : null;
    final TextStyle? titleStyle = theme.textTheme.titleMedium?.copyWith(
        color: isPinned ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onSurface,
        fontWeight: isPinned ? FontWeight.w600 : FontWeight.w500);
    final TextStyle? subtitleStyle = theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return ListTile(
      tileColor: tileBackgroundColor,
      onTap: () => _pinAndUnpinNotification(),
      onLongPress: () => _openDialogEdit(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(
        widget.note.title!,
        style: titleStyle,
      ),
      subtitle: widget.note.text!.isNotEmpty
          ? Text(
              widget.note.text!,
              style: subtitleStyle,
            )
          : null,
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconBackground,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Icon(
          Icons.push_pin_outlined,
          size: 22,
          color: iconColor,
        ),
      ),
    );
  }
}
